<?php

class ModelAccountProfile extends Model {

	public function getProfile($customer_id) {
		$string = "SELECT *,
		cus.firstname as firstname,
		cus.lastname as lastname,
		cus.custom_field as custom_field,
		cus.custom_field as custom_field,
		cgd.name as customer_group,
		cgd.customer_group_id as group_id
		FROM `" . DB_PREFIX . "customer` cus
			LEFT JOIN `" . DB_PREFIX . "address` aa ON (cus.customer_id = aa.customer_id)
			LEFT JOIN `" . DB_PREFIX . "country` con ON (aa.country_id = con.country_id)
			LEFT JOIN `" . DB_PREFIX . "customer_group` cg ON (cus.customer_group_id = cg.customer_group_id)
			LEFT JOIN `" . DB_PREFIX . "customer_group_description` cgd ON (cg.customer_group_id = cgd.customer_group_id)
			WHERE cus.customer_id = '" . (int)$customer_id . "' AND 
			cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'
			";


		$query = $this->db->query($string);

		return $query->row;
	}

	public function getProfiles($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer c ";

		if (!empty($data['filter_customer_group'])) {
			if ($data['filter_customer_group'] == 'donors')
				$sql .= "WHERE customer_group_id = '" . $this->config->get('config_customer_group_donor_id') . "'";
			elseif ($data['filter_customer_group'] == 'beneficiaries')
				$sql .= "WHERE customer_group_id = '" . $this->config->get('config_customer_group_benef_id') . "'";
			
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function addView($customer_id){
		
		$views = $this->getViews($customer_id);

		$query = $this->db->query("UPDATE `" . DB_PREFIX . "customer` SET views = '" . ++$views . "' WHERE customer_id = '" . (int)$customer_id . "';");
	}

	public function getViews($customer_id) {

		$query = $this->db->query("SELECT views FROM `" . DB_PREFIX . "customer` cus WHERE cus.customer_id = '" . (int)$customer_id . "';");

		$result = $query->row;

		return $result['views'];
	}

	public function addReview($profile_id, $data) {
		$this->event->trigger('pre.customer_review.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_review
			SET author = '" . $this->db->escape($data['name']) . "',
			customer_id = '" . (int)$this->customer->getId() . "',
			profile_id = '" . (int)$profile_id . "',
			text = '" . $this->db->escape($data['text']) . "',
			date_added = NOW()");

		$review_id = $this->db->getLastId();

		
		$this->event->trigger('post.customer_review.add', $review_id);
	}

	public function getReviewsByCustomerId($profile_id, $start = 0, $limit = 20) {

		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 20;
		}

		$query = $this->db->query("SELECT r.review_id, r.author, r.text, c.customer_id, c.firstname, c.lastname, r.date_added FROM " . DB_PREFIX . "customer_review r
			LEFT JOIN " . DB_PREFIX . "customer c ON (c.customer_id = r.profile_id)
			WHERE r.profile_id = '" . (int)$profile_id . "'

			ORDER BY r.date_added ASC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	public function getTotalReviewsByCustomerId($profile_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total
			FROM " . DB_PREFIX . "customer_review r WHERE r.profile_id = '" . (int)$profile_id . "'");

		return $query->row['total'];
	}	
}