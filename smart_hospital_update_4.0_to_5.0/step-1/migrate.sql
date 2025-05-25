-- Smart Hospital DB
-- Version 5.0
-- https://smart-hospital.in
-- https://qdocs.net
-- New tables added: 23

SET foreign_key_checks = 0;

ALTER TABLE `appointment` CHANGE `global_shift_id` `doctor_shift_time_id` int DEFAULT NULL;

ALTER TABLE `appointment` CHANGE `shift_id` `doctor_global_shift_id` int DEFAULT NULL;

ALTER TABLE `appointment` CHANGE `live_consult` `live_consult` VARCHAR(50) DEFAULT NULL;

RENAME TABLE `doctor_shift` TO `doctor_shift_time`;

ALTER TABLE `medicine_dosage` CHANGE `charge_units_id` `units_id` int DEFAULT NULL;

ALTER TABLE `doctor_shift_time` CHANGE `global_shift_id` `doctor_global_shift_id` int DEFAULT NULL;

ALTER TABLE medicine_dosage DROP FOREIGN KEY medicine_dosage_ibfk_2;

ALTER TABLE  doctor_shift_time DROP FOREIGN KEY  doctor_shift_time_ibfk_1;

ALTER TABLE `appointment`
  ADD `created_time` datetime DEFAULT NULL after `is_queue`,
  ADD `rejected_time` datetime DEFAULT NULL after `created_time`,
  ADD `live_consult_link` int NOT NULL DEFAULT '1' COMMENT '1 (link created) 0 (not created)' after `live_consult`;

ALTER TABLE `ambulance_call`
  ADD `discount_percentage` float(10,2) DEFAULT '0.00' AFTER `standard_charge`,
  ADD `discount` float(10,2) DEFAULT '0.00' AFTER `discount_percentage`;

ALTER TABLE `transactions` CHANGE `attachment` `attachment` TEXT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL;

ALTER TABLE `transactions`
 ADD `bill_id` int DEFAULT NULL AFTER `received_by`;

CREATE TABLE `staff_attendence_schedules` (
  `id` int primary key AUTO_INCREMENT,
  `staff_attendence_type_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `entry_time_from` time DEFAULT NULL,
  `entry_time_to` time DEFAULT NULL,
  `total_institute_hour` time DEFAULT NULL,
  `is_active` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `primary_examine` (
  `id` int primary key AUTO_INCREMENT,
  `ipdid` int DEFAULT NULL,
  `visit_details_id` int DEFAULT NULL,
  `bleeding` varchar(250) DEFAULT NULL,
  `headache` varchar(250) DEFAULT NULL,
  `pain` varchar(250) DEFAULT NULL,
  `constipation` varchar(250) DEFAULT NULL,
  `urinary_symptoms` varchar(250) NOT NULL,
  `vomiting` varchar(250) DEFAULT NULL,
  `cough` varchar(250) DEFAULT NULL,
  `vaginal` varchar(250) DEFAULT NULL,
  `discharge` varchar(250) DEFAULT NULL,
  `oedema` varchar(250) DEFAULT NULL,
  `haemoroids` varchar(250) DEFAULT NULL,
  `weight` varchar(250) NOT NULL,
  `height` varchar(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `general_condition` text NOT NULL,
  `finding_remark` varchar(250) NOT NULL,
  `pelvic_examination` text NOT NULL,
  `sp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `antenatal_examine` (
  `id` int primary key AUTO_INCREMENT,
  `primary_examine_id` int NOT NULL,
  `visit_details_id` int DEFAULT NULL,
  `ipdid` int DEFAULT NULL,
  `uter_size` varchar(250) DEFAULT NULL,
  `uterus_size` varchar(250) DEFAULT NULL,
  `presentation_position` varchar(250) DEFAULT NULL,
  `brim_presentation` varchar(250) DEFAULT NULL,
  `foeta_heart` varchar(250) DEFAULT NULL,
  `blood_pressure` varchar(250) DEFAULT NULL,
  `antenatal_oedema` varchar(250) DEFAULT NULL,
  `antenatal_weight` varchar(250) DEFAULT NULL,
  `urine_sugar` varchar(250) DEFAULT NULL,
  `urine` varchar(250) DEFAULT NULL,
  `remark` text,
  `next_visit` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE appointment_payment
  ADD `standard_amount` float(10,2) NOT NULL DEFAULT '0.00' AFTER `charge_id`,
  ADD `tax` float(10,2) NOT NULL DEFAULT '0.00' AFTER `standard_amount`,
  ADD `discount_percentage` float(10,2) NOT NULL DEFAULT '0.00' AFTER `tax`,
  ADD `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `date`;
  
CREATE TABLE `bill` (
  `id` int primary key AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `attachment` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `attachment_name` mediumtext,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` mediumtext,
  `received_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE birth_report
MODIFY COLUMN  `child_pic` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
MODIFY COLUMN  `mother_pic` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
MODIFY COLUMN  `father_pic` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
MODIFY COLUMN  `document` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE blood_donor_cycle 
 MODIFY COLUMN  `institution` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE blood_issue
  MODIFY COLUMN `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  MODIFY COLUMN `reference` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  MODIFY COLUMN `institution` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  MODIFY COLUMN `technician` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  ADD `organisation_id` int DEFAULT NULL AFTER `remark`,
  ADD `insurance_validity` date DEFAULT NULL AFTER `organisation_id`,
  ADD `insurance_id` varchar(250) DEFAULT NULL AFTER `insurance_validity`;

ALTER TABLE case_references
 ADD `bill_id` int DEFAULT NULL AFTER `id`,
 ADD `discount_percentage` float(10,2) NOT NULL DEFAULT '0.00' AFTER `bill_id`; 

ALTER TABLE  certificates
 MODIFY  `background_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE complaint
MODIFY `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE  conferences
 ADD `live_consult_link` int NOT NULL DEFAULT '1' COMMENT 'appointment zoom link for front user status' AFTER `status`;

 ALTER TABLE contents
MODIFY `file` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

CREATE TABLE `content_types` (
  `id` int primary key AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` text,
  `is_active` int DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE death_report
MODIFY   `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

CREATE TABLE `duty_roster_assign` (
  `id` int primary key AUTO_INCREMENT,
  `code` int NOT NULL,
  `roster_duty_date` date DEFAULT NULL,
  `floor_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `staff_id` int NOT NULL,
  `duty_roster_list_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `duty_roster_list` (
  `id` int primary key AUTO_INCREMENT,
  `duty_roster_shift_id` int NOT NULL,
  `duty_roster_start_date` date NOT NULL,
  `duty_roster_end_date` date NOT NULL,
  `duty_roster_total_day` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `duty_roster_shift` (
  `id` int primary key AUTO_INCREMENT,
  `shift_name` varchar(255) NOT NULL,
  `shift_start` time NOT NULL,
  `shift_end` time NOT NULL,
  `shift_hour` time NOT NULL,
  `is_active` int NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE expenses
 MODIFY `documents` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

CREATE TABLE `filetypes` (
  `id` int primary key AUTO_INCREMENT,
  `file_extension` text,
  `file_mime` text,
  `file_size` int NOT NULL,
  `image_extension` text,
  `image_mime` text,
  `image_size` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE front_cms_programs
 MODIFY `feature_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE front_cms_settings
 MODIFY `logo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
 
CREATE TABLE `gateway_ins` (
  `id` int primary key AUTO_INCREMENT,
  `online_appointment_id` int DEFAULT NULL,
  `type` varchar(30) NOT NULL COMMENT 'patient_bill,appointment	',
  `gateway_name` varchar(50) NOT NULL,
  `module_type` varchar(255) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  `parameter_details` mediumtext NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `gateway_ins_response` (
  `id` int primary key AUTO_INCREMENT,
  `gateway_ins_id` int DEFAULT NULL,
  `posted_data` text,
  `response` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE income
MODIFY  `documents` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE ipd_details
ADD `is_antenatal` int DEFAULT NULL AFTER `generated_by`,
MODIFY  `bed` int DEFAULT NULL,
MODIFY `symptoms` longtext NOT NULL;

ALTER TABLE `ipd_details` CHANGE `live_consult` `live_consult` VARCHAR(50) DEFAULT NULL;

ALTER TABLE ipd_prescription_basic
 ADD `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL AFTER `visit_details_id`,
 ADD `attachment_name` text NOT NULL AFTER `attachment`;

ALTER TABLE item
 MODIFY  `item_photo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE item_stock
  MODIFY `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

CREATE TABLE `medicine_group` (
  `id` int primary key AUTO_INCREMENT,
  `group_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


ALTER TABLE nurse_note
  ADD `created_by` int NOT NULL AFTER `comment`,
  ADD `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `updated_at`;
  
CREATE TABLE `obstetric_history` (
  `id` int primary key AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `place_of_delivery` varchar(250) NOT NULL,
  `pregnancy_duration` varchar(250) NOT NULL,
  `pregnancy_complications` varchar(250) NOT NULL,
  `birth_weight` varchar(250) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `infant_feeding` varchar(250) NOT NULL,
  `alive_dead` varchar(50) NOT NULL,
  `date` date DEFAULT NULL,
  `death_cause` varchar(250) NOT NULL,
  `previous_medical_history` text NOT NULL,
  `special_instruction` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE  operation_theatre
  MODIFY `result` text,
  MODIFY `remark` text;

ALTER TABLE  pathology_billing
 ADD `organisation_id` int DEFAULT NULL AFTER `note`,
 ADD `insurance_validity` date DEFAULT NULL AFTER `organisation_id`,
 ADD `insurance_id` varchar(250) DEFAULT NULL;

ALTER TABLE pathology_parameter
ADD `range_from` varchar(500) DEFAULT NULL AFTER `reference_range`,
ADD `range_to` varchar(500) DEFAULT NULL AFTER `range_from`;

ALTER TABLE patients
 ADD `as_of_date` date DEFAULT NULL AFTER `day`,
 ADD `organisation_id` int DEFAULT NULL AFTER `app_key`,
 ADD `is_antenatal` int NOT NULL AFTER `is_dead`,
 MODIFY  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

CREATE TABLE `patients_vitals` (
  `id` int primary key AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `vital_id` int NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `messure_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE patient_charges
 ADD `discount_percentage` float(10,2) DEFAULT '0.00' AFTER `tpa_charge`,
 ADD `organisation_id` int DEFAULT NULL AFTER `note`,
 ADD `insurance_validity` date DEFAULT NULL AFTER `organisation_id`,
 ADD `insurance_id` varchar(250) DEFAULT NULL AFTER `insurance_validity`;

ALTER TABLE patient_id_card
 modify `background` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 modify `logo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 modify `sign_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 ADD `enable_barcode` tinyint(1) NOT NULL COMMENT '0=disable,1=enable' AFTER `status`;

ALTER TABLE patient_timeline
 modify  `timeline_date` datetime DEFAULT NULL,
 modify   `document` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 modify   `date` datetime DEFAULT NULL;

ALTER TABLE pharmacy
 modify `medicine_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 ADD `rack_number` varchar(255) NOT NULL AFTER `vat_ac`;

CREATE TABLE `pharmacy_company` (
  `id` int primary key AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `postnatal_examine` (
  `id` int primary key AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `labor_time` datetime NOT NULL,
  `delivery_time` datetime NOT NULL,
 `routine_question` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `general_remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE print_setting
 modify `print_header` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
 modify `print_footer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

 ALTER TABLE radio
 modify `test_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL;

 ALTER TABLE visit_details
 modify   `symptoms` text;

ALTER TABLE radiology_billing
  ADD `organisation_id` int DEFAULT NULL after `note`,
  ADD `insurance_validity` date DEFAULT NULL after `organisation_id`,
  ADD `insurance_id` varchar(250) DEFAULT NULL after `insurance_validity`;

ALTER TABLE radiology_parameter
  ADD `range_from` varchar(500) DEFAULT NULL AFTER `reference_range`,
 ADD `range_to` varchar(500) DEFAULT NULL AFTER `range_from`;

ALTER TABLE referral_payment
 ADD  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `date`;

ALTER TABLE sch_settings
  ADD `base_url` varchar(500) DEFAULT NULL AFTER `id`,
  ADD `folder_path` text AFTER `base_url`,
  ADD `biometric` int DEFAULT '0' AFTER `name`,
 ADD `biometric_device` text AFTER `biometric`,
 ADD `scan_code_type` varchar(50) NOT NULL DEFAULT 'barcode' AFTER `patient_panel`;
 
CREATE TABLE `share_contents` (
  `id` int primary key AUTO_INCREMENT,
  `send_to` varchar(50) DEFAULT NULL,
  `title` text,
  `share_date` date DEFAULT NULL,
  `valid_upto` date DEFAULT NULL,
  `description` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `share_content_for` (
  `id` int primary key AUTO_INCREMENT,
  `group_id` varchar(20) DEFAULT NULL,
  `patient_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `share_content_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `share_upload_contents` (
  `id` int primary key AUTO_INCREMENT,
  `upload_content_id` int DEFAULT NULL,
  `share_content_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE staff_attendance
  ADD `biometric_attendence` int DEFAULT '0' AFTER `staff_attendance_type_id`,
  ADD `biometric_device_data` text AFTER `biometric_attendence`,
  ADD `user_agent` varchar(255) DEFAULT NULL AFTER `biometric_device_data`,
  ADD `in_time` time DEFAULT NULL AFTER `is_active`,
  ADD `out_time` time DEFAULT NULL AFTER `in_time`;

ALTER TABLE staff_attendance_type
  ADD `long_lang_name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL AFTER `is_active`,
  ADD `long_name_style` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL AFTER `long_lang_name`,
  ADD `for_schedule` int NOT NULL DEFAULT '0' AFTER `long_name_style`,
  ADD `updated_at` date DEFAULT NULL AFTER `created_at`;

ALTER TABLE staff_id_card
  modify `background` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  modify `logo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  modify `sign_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  ADD `enable_staff_barcode` tinyint(1) NOT NULL COMMENT '0=disable,1=enable' AFTER `enable_staff_phone`;

ALTER TABLE staff_leave_request
  modify   `document_file` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  ADD  `approved_date` date DEFAULT NULL  AFTER `status`;

ALTER TABLE staff_timeline
  modify `document` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  ADD `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `date`;

ALTER TABLE `transactions` CHANGE `attachment` `attachment` TEXT  NULL DEFAULT NULL;
    
CREATE TABLE `transactions_processing` (
  `id` int primary key AUTO_INCREMENT,
  `gateway_ins_id` int NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `section` varchar(50) NOT NULL,
  `patient_id` int DEFAULT NULL,
  `case_reference_id` int DEFAULT NULL,
  `opd_id` int DEFAULT NULL,
  `ipd_id` int DEFAULT NULL,
  `pharmacy_bill_basic_id` int DEFAULT NULL,
  `pathology_billing_id` int DEFAULT NULL,
  `radiology_billing_id` int DEFAULT NULL,
  `blood_donor_cycle_id` int DEFAULT NULL,
  `blood_issue_id` int DEFAULT NULL,
  `ambulance_call_id` int DEFAULT NULL,
  `appointment_id` int DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `attachment_name` text,
  `amount_type` varchar(10) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` text,
  `received_by` int DEFAULT NULL,
  `bill_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `upload_contents` (
  `id` int primary key AUTO_INCREMENT,
  `content_type_id` int NOT NULL,
  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `thumb_path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `dir_path` varchar(300) DEFAULT NULL,
  `real_name` text NOT NULL,
  `img_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `thumb_name` varchar(300) DEFAULT NULL,
  `file_type` varchar(100) NOT NULL,
  `mime_type` text NOT NULL,
  `file_size` varchar(100) NOT NULL,
  `vid_url` text NOT NULL,
  `vid_title` varchar(250) NOT NULL,
  `upload_by` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE visitors_book
modify `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE visit_details
ADD `is_antenatal` int NOT NULL AFTER `live_consult`;

CREATE TABLE `vitals` (
  `id` int primary key AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `unit` varchar(11) DEFAULT NULL,
  `is_system` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `vitals` (`id`, `name`, `reference_range`, `unit`, `is_system`, `created_at`) VALUES
(1, 'Height', '1  -  200', 'Centimeters', 1, '2024-03-14 06:03:18'),
(2, 'Weight', '0  -  150', 'Kilograms', 1, '2024-05-20 09:06:24'),
(3, 'Pulse ', '70 -   100 ', 'Beats per', 1, '2024-03-07 11:27:43'),
(4, 'Temperature', '95.8  -  99.3', 'Fahrenheit ', 1, '2024-05-16 10:59:30'),
(5, 'BP', '90/60  -  140/90', 'mmHg', 1, '2024-03-07 11:27:48');

INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES
(44, 'Duty Roster', 'duty_roster', 1, 0, 12.10, '2024-08-09 10:37:56'),
(45, 'Annual Calendar', 'annual_calendar', 1, 0, 12.20, '2024-08-17 06:32:13');

UPDATE `permission_category` SET `name` = 'Content Type' WHERE `permission_category`.`id` = 27;

UPDATE `permission_category` SET `short_code` = 'content_type' WHERE `permission_category`.`id` = 27;

UPDATE `permission_category` SET `enable_edit` = '1' WHERE `permission_category`.`id` = 27;

UPDATE `permission_category` SET `enable_edit` = '1' WHERE `permission_category`.`id` = 90;

UPDATE `permission_category` SET `enable_edit` = '1' WHERE `permission_category`.`id` = 144;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 192;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 197;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 201;

UPDATE `permission_category` SET `enable_edit` = '1' WHERE `permission_category`.`id` = 222;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 240;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 242;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 243;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 244;

UPDATE `permission_category` SET `enable_delete` = '0' WHERE `permission_category`.`id` = 247;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 247;

UPDATE `permission_category` SET `enable_add` = '0' WHERE `permission_category`.`id` = 247;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 248;

UPDATE `permission_category` SET `enable_delete` = '0' WHERE `permission_category`.`id` = 249;

UPDATE `permission_category` SET `enable_edit` = '0' WHERE `permission_category`.`id` = 249;

UPDATE `permission_category` SET `enable_add` = '0' WHERE `permission_category`.`id` = 249;

UPDATE `permission_category` SET `enable_edit` = '1' WHERE `permission_category`.`id` = 264;

INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES 
(388, 15, 'Finding', 'finding', 1, 1, 1, 1, '2021-10-29 07:45:14'),
(389, 15, 'Finding Category', 'finding_category', 1, 1, 1, 1, '2021-10-29 07:45:14'),
(390, 41, 'Appointment Billing', 'appointment_billing', 1, 0, 0, 0, '2021-09-09 00:53:03'),
(391, 15, 'Vital', 'vital', 1, 1, 1, 1, '2021-10-29 07:45:14'),
(392, 23, 'OPD Vitals', 'opd_vitals', 1, 1, 1, 1, '2018-12-19 22:37:26'),
(393, 24, 'IPD Vitals', 'ipd_vitals', 1, 1, 1, 1, '2021-02-25 01:30:00'),
(394, 24, 'Previous Obstetric History', 'ipd_previous_obstetric_history', 1, 1, 1, 1, '2021-02-25 01:30:00'),
(395, 24, 'Postnatal History', 'ipd_postnatal_history', 1, 1, 1, 1, '2021-02-25 01:30:00'),
(396, 24, 'Antenatal', 'ipd_antenatal', 1, 1, 1, 1, '2021-02-25 01:30:00'),
(397, 39, 'Print Appointment Header Footer', 'print_appointment_header_footer', 1, 0, 0, 0, '2024-02-29 09:05:48'),
(398, 23, 'Antenatal', 'opd_antenatal', 1, 1, 1, 1, '2024-03-11 11:24:19'),
(399, 41, 'Payment Receipt Header Footer', 'payment_receipt_header_footer', 1, 0, 0, 0, '2024-02-29 10:44:39'),
(400, 13, 'Send Credential', 'send_credential', 1, 0, 0, 0, '2024-02-29 10:44:43'),
(401, 24, 'IPD Antenatal Finding Print Header Footer', 'ipd_antenatal_finding_print_header_footer', 1, 0, 0, 0, '2024-02-29 10:44:47'),
(402, 23, 'OPD Antenatal Finding Print Header Footer ', 'opd_antenatal_finding_print_header_footer', 1, 0, 0, 0, '2024-02-29 10:44:52'),
(403, 24, 'Discharge Summary Print Header Footer', 'discharge_summary_print_header_footer', 1, 0, 0, 0, '2024-02-29 10:44:57'),
(404, 24, 'IPD Obstetric History Print Header Footer', 'ipd_obstetric_history_print_header_footer', 1, 0, 0, 0, '2024-02-29 10:44:47'),
(405, 39, 'Appointment Priority', 'appointment_priority', 1, 1, 1, 1, '2021-06-12 01:24:25'),
(406, 25, 'Unit', 'medicine_unit', 1, 1, 1, 1, '2018-10-24 19:10:24'),
(407, 25, 'Company', 'medicine_company', 1, 1, 1, 1, '2018-10-24 19:10:24'),
(408, 25, 'Medicine Group', 'medicine_group', 1, 1, 1, 1, '2018-10-24 19:10:24'),
(409, 8, 'Content Share List', 'content_share_list', 1, 0, 0, 1, '2024-04-20 06:05:46'),
(410, 8, 'Upload/Share Content', 'upload_share_content', 1, 1, 0, 1, '2024-04-20 06:41:55'),
(411, 8, 'Generate URL', 'generate_url', 1, 0, 0, 0, '2024-04-20 06:41:55'),
(412, 8, 'Share', 'share_content', 1, 0, 0, 0, '2024-04-20 06:41:55'),
(413, 23, 'OPD Bill Print Header Footer', 'opd_bill_print_header_footer', 1, 0, 1, 0, '2024-05-01 12:39:20'),
(414, 15, 'Attendance Setting', 'attendance_setting', 1, 0, 1, 0, '2018-07-04 22:08:35'),
(415, 44, 'Duty Roster', 'duty_roster', 1, 0, 0, 0, '2018-07-04 22:08:35'),
(416, 44, 'Shift', 'roster_shift', 1, 1, 1, 1, '2024-08-08 09:03:23'),
(417, 44, 'Roster List', 'roster_list', 1, 1, 1, 1, '2018-07-04 22:08:35'),
(418, 44, 'Roster Assign', 'roster_assign', 1, 1, 1, 1, '2018-07-04 22:08:35'),
(419, 45, 'Annual Calendar', 'annual_calendar', 1, 1, 1, 1, '2018-07-04 22:08:35');

INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES
(null, 1, 419, 1, 1, 1, 1, '2024-08-20 10:19:15'),
(null, 1, 415, 1, 0, 0, 0, '2024-08-20 10:19:36'),
(null, 1, 416, 1, 1, 1, 1, '2024-08-20 10:19:36'),
(null, 1, 417, 1, 1, 1, 1, '2024-08-20 10:19:36'),
(null, 1, 418, 1, 1, 1, 1, '2024-08-20 10:19:36'),
(null, 1, 414, 1, 0, 1, 0, '2024-08-20 10:20:08'),
(null, 1, 398, 1, 1, 1, 1, '2024-08-20 10:21:04'),
(null, 1, 402, 1, 0, 0, 0, '2024-08-20 10:21:04'),
(null, 1, 413, 1, 0, 1, 0, '2024-08-20 10:21:04'),
(null, 1, 409, 1, 0, 0, 1, '2024-08-20 10:21:50'),
(null, 1, 410, 1, 1, 0, 1, '2024-08-20 10:21:50'),
(null, 1, 411, 1, 0, 0, 0, '2024-08-20 10:21:50'),
(null, 1, 412, 1, 0, 0, 0, '2024-08-20 10:21:50'),
(null, 1, 406, 1, 1, 1, 1, '2024-08-20 10:22:23'),
(null, 1, 407, 1, 1, 1, 1, '2024-08-20 10:22:23'),
(null, 1, 408, 1, 1, 1, 1, '2024-08-20 10:22:23'),
(null, 1, 405, 1, 1, 1, 1, '2024-08-20 10:22:33'),
(null, 1, 393, 1, 1, 1, 1, '2024-08-20 10:23:11'),
(null, 1, 394, 1, 1, 1, 1, '2024-08-20 10:23:11'),
(null, 1, 395, 1, 1, 1, 1, '2024-08-20 10:23:11'),
(null, 1, 396, 1, 1, 1, 1, '2024-08-20 10:23:11'),
(null, 1, 401, 1, 0, 0, 0, '2024-08-20 10:23:11'),
(null, 1, 403, 1, 0, 0, 0, '2024-08-20 10:23:11'),
(null, 1, 404, 1, 0, 0, 0, '2024-08-20 10:23:11'),
(null, 1, 392, 1, 1, 1, 1, '2024-08-20 10:25:03'),
(null, 1, 400, 1, 0, 0, 0, '2024-08-20 10:25:23'),
(null, 1, 390, 1, 0, 0, 0, '2024-08-20 10:25:53'),
(null, 1, 399, 1, 0, 0, 0, '2024-08-20 10:25:53'),
(null, 1, 388, 1, 1, 1, 1, '2024-08-20 10:27:59'),
(null, 1, 389, 1, 1, 1, 1, '2024-08-20 10:27:59'),
(null, 1, 391, 1, 1, 1, 1, '2024-08-20 10:27:59'),
(null, 1, 397, 1, 0, 0, 0, '2024-08-20 10:31:13');

UPDATE `permission_group` SET `name` = 'Billing' WHERE `permission_group`.`id` = 41;

INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES
(12, 'download_center', 'Download Center', 'download_center', 1, 0, 12.00, '2024-06-26 12:29:50');

INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES
(17, 'uploads/printing/17.jpg', '', 'obstetric_history', 'yes', '2021-09-25 06:44:20'),
(18, 'uploads/printing/18.jpg', '', 'opd_antenatal_finding', 'yes', '2021-09-25 06:44:20'),
(19, 'uploads/printing/19.jpg', '', 'ipd_antenatal_finding', 'yes', '2021-09-25 06:44:20'),
(20, 'uploads/printing/20.jpg', '', 'appointment', 'yes', '2021-09-25 06:44:20');

INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `long_lang_name`, `long_name_style`, `for_schedule`, `created_at`, `updated_at`) VALUES
(6, 'Half Day Second Shift', '<b class=\"text text-warning\">SH</b>', 'yes', 'half_day_second_shift', 'label label-info', 1, '2024-06-08 16:35:55', NULL);

UPDATE `staff_attendance_type` SET `for_schedule` = '1' WHERE `staff_attendance_type`.`id` = 1;
UPDATE `staff_attendance_type` SET `for_schedule` = '1' WHERE `staff_attendance_type`.`id` = 2;
UPDATE `staff_attendance_type` SET `for_schedule` = '1' WHERE `staff_attendance_type`.`id` = 4;
UPDATE `staff_attendance_type` SET `long_lang_name` = 'present' WHERE `staff_attendance_type`.`id` = 1;
UPDATE `staff_attendance_type` SET `long_lang_name` = 'late' WHERE `staff_attendance_type`.`id` = 2;
UPDATE `staff_attendance_type` SET `long_lang_name` = 'absent' WHERE `staff_attendance_type`.`id` = 3;
UPDATE `staff_attendance_type` SET `long_lang_name` = 'half_day' WHERE `staff_attendance_type`.`id` = 4;
UPDATE `staff_attendance_type` SET `long_lang_name` = 'holiday' WHERE `staff_attendance_type`.`id` = 5;

INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES 
(60, 'add_ipd_previous_obstetric_history', 'Add IPD  Previous Obstetric History', 'IPD  Previous Obstetric History been created for Patient: {{patient_name}} ({{patient_id}}).', 1, 'IPD  Previous Obstetric History been created for Patient: {{patient_name}} ({{patient_id}}). ', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{place_of_delivery}}', '', '', 'ipd', 1, '2021-09-17 02:54:13'),
(61, 'add_ipd_postnatal_history', 'Add IPD Postnatal History', 'IPD Postnatal History\r\n has been created for Patient: {{patient_name}} ({{patient_id}}).', 1, 'IPD Postnatal History\r\n has been created for Patient: {{patient_name}} ({{patient_id}}).\r\n', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{labor_time}} {{delivery_time}}', '', '', 'ipd', 1, '2021-09-17 02:54:13'),
(62, 'add_ipd_antenatal', 'Add IPD Antenatal', 'IPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).', 1, 'IPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}). \r\n\r\n', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{date}}', '', '', 'ipd', 1, '2021-09-17 02:54:13'),
(63, 'add_opd_antenatal', 'Add OPD Antenatal', 'OPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).',1, '\r\n OPD Antenatal has been created for Patient: {{patient_name}} ({{patient_id}}).', 1, '{{patient_name}} {{patient_id}} {{opd_no}} {{case_id}} {{date}}', '', '', 'opd', 1, '2021-09-17 02:54:13'),
(64, 'opd_new_checkup_created', 'OPD New Checkup Created', 'OPD New Checkup Created {{patient_name}} doctor and admin msg', 1, 'OPD New Checkup Created {{patient_name}} patient mesg', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{place_of_delivery}}', '', '', 'opd', 1, '2021-09-17 02:54:13');

UPDATE `front_cms_settings` SET `theme` = 'turquoise_blue' WHERE `front_cms_settings`.`id` = 1;

CREATE TABLE `annual_calendar` (
  `id` int NOT NULL,
  `holiday_type` int NOT NULL COMMENT '1 for holiday , 2 for activity , 3 for vacation',
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `description` text NOT NULL COMMENT 'Holiday Description',
  `is_active` int NOT NULL DEFAULT '1' COMMENT '1 for active 0 for inactive',
  `holiday_color` varchar(200) NOT NULL,
  `front_site` int NOT NULL DEFAULT '0',
  `created_by` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE `annual_calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_holiday_type` (`holiday_type`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `index_from_date` (`from_date`) USING BTREE,
  ADD KEY `index_to_date` (`to_date`) USING BTREE; 
  
ALTER TABLE `annual_calendar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `annual_calendar`
  ADD CONSTRAINT `annual_calendar_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `ambulance_call`
  ADD KEY `charge_id` (`charge_id`),
  ADD KEY `idx_contact_no` (`contact_no`),
  ADD KEY `idx_vehicle_model` (`vehicle_model`),
  ADD KEY `idx_driver` (`driver`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_call_from` (`call_from`),
  ADD KEY `index_call_to` (`call_to`),
  ADD KEY `index_charge_category_id` (`charge_category_id`),
  ADD KEY `index_standard_charge` (`standard_charge`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_discount` (`discount`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_net_amount` (`net_amount`);

ALTER TABLE `antenatal_examine`
  ADD KEY `visit_details_id` (`visit_details_id`),
  ADD KEY `ipdid` (`ipdid`),
  ADD KEY `index_uter_size` (`uter_size`),
  ADD KEY `index_uterus_size` (`uterus_size`),
  ADD KEY `index_presentation_position` (`presentation_position`),
  ADD KEY `index_brim_presentation` (`brim_presentation`),
  ADD KEY `index_foeta_heart` (`foeta_heart`),
  ADD KEY `index_blood_pressure` (`blood_pressure`),
  ADD KEY `index_antenatal_oedema` (`antenatal_oedema`),
  ADD KEY `index_antenatal_weight` (`antenatal_weight`),
  ADD KEY `index_urine_sugar` (`urine_sugar`),
  ADD KEY `index_urine` (`urine`),
  ADD KEY `primary_examine_id` (`primary_examine_id`);

ALTER TABLE `appointment_payment`
  ADD KEY `index_standard_amount` (`standard_amount`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_paid_amount` (`paid_amount`),
  ADD KEY `index_payment_mode` (`payment_mode`),
  ADD KEY `index_payment_type` (`payment_type`);

ALTER TABLE `appoint_priority`
  ADD KEY `index_appoint_priority` (`appoint_priority`);

ALTER TABLE `bed`
  ADD KEY `index_name` (`name`);

ALTER TABLE `bed_group`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_color` (`color`);

ALTER TABLE `bed_type`
  ADD KEY `index_name` (`name`);

ALTER TABLE `bill`
  ADD KEY `case_id` (`case_id`);

ALTER TABLE `birth_report`
  ADD KEY `index_child_name` (`child_name`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_weight` (`weight`),
  ADD KEY `index_contact` (`contact`);

ALTER TABLE `blood_bank_products`
  ADD KEY `index_name` (`name`);

ALTER TABLE `blood_donor`
  ADD KEY `index_donor_name` (`donor_name`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_father_name` (`father_name`),
  ADD KEY `index_contact_no` (`contact_no`);

ALTER TABLE `blood_donor_cycle`
  ADD KEY `index_bag_no` (`bag_no`),
  ADD KEY `index_lot` (`lot`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_unit` (`unit`),
  ADD KEY `index_volume` (`volume`),
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_standard_charge` (`standard_charge`),
  ADD KEY `index_apply_charge` (`apply_charge`);

ALTER TABLE `blood_issue`
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `organisation_id` (`organisation_id`),
  ADD KEY `index_standard_charge` (`standard_charge`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_net_amount` (`net_amount`),
  ADD KEY `hospital_doctor` (`hospital_doctor`);

ALTER TABLE `case_references`
  ADD KEY `case_references_ibfk_1` (`bill_id`);

ALTER TABLE `charges`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_standard_charge` (`standard_charge`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `charge_categories`
  ADD KEY `index_name` (`name`);

ALTER TABLE `charge_type_master`
  ADD KEY `index_charge_type` (`charge_type`);

ALTER TABLE `charge_units`
  ADD KEY `index_unit` (`unit`);

ALTER TABLE `complaint_type`
  ADD KEY `index_complaint_type` (`complaint_type`);
  
ALTER TABLE `contents`
  ADD KEY `index_title` (`title`);

ALTER TABLE `content_types`
  ADD KEY `index_name` (`name`);

ALTER TABLE `custom_fields`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_belong_to` (`belong_to`),
  ADD KEY `index_type` (`type`),
  ADD KEY `index_visible_on_table` (`visible_on_table`),
  ADD KEY `index_visible_on_print` (`visible_on_print`),
  ADD KEY `index_visible_on_report` (`visible_on_report`);

ALTER TABLE `custom_field_values`
  ADD KEY `index_field_value` (`field_value`),
  ADD KEY `index_belong_table_id` (`belong_table_id`),
  ADD KEY `index_custom_field_id` (`custom_field_id`);

ALTER TABLE `department`
  ADD KEY `index_department_name` (`department_name`);

ALTER TABLE `dispatch_receive`
  ADD KEY `index_reference_no` (`reference_no`),
  ADD KEY `index_to_title` (`to_title`),
  ADD KEY `index_from_title` (`from_title`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `doctor_absent`
  ADD KEY `index_date` (`date`);

ALTER TABLE `dose_duration`
  ADD KEY `index_name` (`name`);

ALTER TABLE `dose_interval`
  ADD KEY `index_name` (`name`);
  
ALTER TABLE `duty_roster_assign`
  ADD KEY `duty_roster_list_id` (`duty_roster_list_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `floor_id` (`floor_id`),
  ADD KEY `index_roster_duty_date` (`roster_duty_date`);

ALTER TABLE `duty_roster_list`
  ADD KEY `duty_roster_shift_id` (`duty_roster_shift_id`),
  ADD KEY `index_duty_roster_start_date` (`duty_roster_start_date`),
  ADD KEY `index_duty_roster_end_date` (`duty_roster_end_date`);

ALTER TABLE `duty_roster_shift`
  ADD KEY `index_shift_name` (`shift_name`),
  ADD KEY `index_shift_start` (`shift_start`),
  ADD KEY `index_shift_end` (`shift_end`),
  ADD KEY `index_shift_hour` (`shift_hour`);

ALTER TABLE `events`
  ADD KEY `start_date` (`start_date`),
  ADD KEY `index_end_date` (`end_date`),
  ADD KEY `index_event_type` (`event_type`) USING BTREE,
  ADD KEY `index_event_color` (`event_color`) USING BTREE,
  ADD KEY `index_event_title` (`event_title`),
  ADD KEY `role_id` (`role_id`);

ALTER TABLE `expenses`
  ADD KEY `index_invoice_no` (`invoice_no`),
  ADD KEY `index_name` (`name`),
  ADD KEY `index_date` (`date`) USING BTREE,
  ADD KEY `index_amount` (`amount`) USING BTREE;

ALTER TABLE `expense_head`
  ADD KEY `index_exp_category` (`exp_category`);

ALTER TABLE `finding`
  ADD KEY `index_name` (`name`);

ALTER TABLE `finding_category`
  ADD KEY `index_category` (`category`);

ALTER TABLE `floor`
  ADD KEY `index_name` (`name`);

ALTER TABLE `gateway_ins`
  ADD KEY `index_type` (`type`),
  ADD KEY `index_gateway_name` (`gateway_name`),
  ADD KEY `index_module_type` (`module_type`),
  ADD KEY `index_unique_id` (`unique_id`),
  ADD KEY `online_appointment_id` (`online_appointment_id`);

ALTER TABLE `gateway_ins_response`
  ADD KEY `gateway_ins_id` (`gateway_ins_id`);

ALTER TABLE `general_calls`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_contact` (`contact`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_call_duration` (`call_duration`),
  ADD KEY `index_follow_up_date` (`follow_up_date`);

ALTER TABLE `global_shift`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_start_time` (`start_time`),
  ADD KEY `index_end_time` (`end_time`);

ALTER TABLE `income`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_invoice_no` (`invoice_no`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_amount` (`amount`);

ALTER TABLE `income_head`
  ADD KEY `index_income_category` (`income_category`);

ALTER TABLE `ipd_details`
  ADD KEY `bed` (`bed`);

ALTER TABLE `ipd_prescription_basic`
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `index_date` (`date`),
  ADD KEY `prescribe_by` (`prescribe_by`);

ALTER TABLE `ipd_prescription_details`
  ADD KEY `index_dosage` (`dosage`),
  ADD KEY `index_dose_interval_id` (`dose_interval_id`),
  ADD KEY `index_dose_duration_id` (`dose_duration_id`);

ALTER TABLE `item`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_unit` (`unit`),
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `item_category`
  ADD KEY `index_item_category` (`item_category`);

ALTER TABLE `item_issue`
  ADD KEY `index_issue_date` (`issue_date`),
  ADD KEY `index_return_date` (`return_date`),
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_is_returned` (`is_returned`);

ALTER TABLE `item_stock`
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_purchase_price` (`purchase_price`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `item_store`
  ADD KEY `index_item_store` (`item_store`),
  ADD KEY `index_code` (`code`);

ALTER TABLE `item_supplier`
  ADD KEY `index_item_supplier` (`item_supplier`),
  ADD KEY `index_phone` (`phone`),
  ADD KEY `index_email` (`email`),
  ADD KEY `index_address` (`address`),
  ADD KEY `index_contact_person_name` (`contact_person_name`),
  ADD KEY `index_contact_person_phone` (`contact_person_phone`),
  ADD KEY `index_contact_person_email` (`contact_person_email`);

ALTER TABLE `languages`
  ADD KEY `index_language` (`language`),
  ADD KEY `index_short_code` (`short_code`),
  ADD KEY `index_country_code` (`country_code`),
  ADD KEY `index_is_deleted` (`is_deleted`),
  ADD KEY `index_is_rtl` (`is_rtl`);

ALTER TABLE `medication_report`
  ADD KEY `opd_details_id` (`opd_details_id`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_time` (`time`);

ALTER TABLE `medicine_bad_stock`
  ADD KEY `medicine_batch_details_id` (`medicine_batch_details_id`),
  ADD KEY `index_outward_date` (`outward_date`),
  ADD KEY `index_expiry_date` (`expiry_date`),
  ADD KEY `index_batch_no` (`batch_no`),
  ADD KEY `index_quantity` (`quantity`);

ALTER TABLE `medicine_batch_details`
  ADD KEY `index_inward_date` (`inward_date`),
  ADD KEY `index_expiry` (`expiry`),
  ADD KEY `index_batch_no` (`batch_no`),
  ADD KEY `index_packing_qty` (`packing_qty`),
  ADD KEY `index_purchase_rate_packing` (`purchase_rate_packing`),
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_mrp` (`mrp`),
  ADD KEY `index_purchase_price` (`purchase_price`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_sale_rate` (`sale_rate`),
  ADD KEY `index_batch_amount` (`batch_amount`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_available_quantity` (`available_quantity`);

ALTER TABLE `medicine_category`
  ADD KEY `index_medicine_category` (`medicine_category`);

ALTER TABLE `medicine_dosage`
  ADD KEY `index_dosage` (`dosage`);

ALTER TABLE `prefixes`
  ADD KEY `index_type` (`type`);

ALTER TABLE `medicine_supplier`
  ADD KEY `index_supplier` (`supplier`),
  ADD KEY `index_contact` (`contact`),
  ADD KEY `index_supplier_person` (`supplier_person`),
  ADD KEY `index_supplier_person_contact` (`supplier_person_contact`),
  ADD KEY `index_supplier_drug_licence` (`supplier_drug_licence`);

ALTER TABLE `messages`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_send_mail` (`send_mail`),
  ADD KEY `index_send_sms` (`send_sms`),
  ADD KEY `index_is_group` (`is_group`),
  ADD KEY `index_is_individual` (`is_individual`);

ALTER TABLE `notification_setting`
  ADD KEY `index_type` (`type`),
  ADD KEY `index_is_mail` (`is_mail`),
  ADD KEY `index_is_sms` (`is_sms`),
  ADD KEY `index_is_mobileapp` (`is_mobileapp`),
  ADD KEY `index_is_notification` (`is_notification`),
  ADD KEY `index_display_notification` (`display_notification`),
  ADD KEY `index_display_sms` (`display_sms`);

ALTER TABLE `nurse_note`
  ADD KEY `index_date` (`date`);

ALTER TABLE `obstetric_history`
  ADD KEY `index_place_of_delivery` (`place_of_delivery`),
  ADD KEY `index_pregnancy_duration` (`pregnancy_duration`),
  ADD KEY `index_pregnancy_complications` (`pregnancy_complications`),
  ADD KEY `index_birth_weight` (`birth_weight`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_infant_feeding` (`infant_feeding`),
  ADD KEY `index_alive_dead` (`alive_dead`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_death_cause` (`death_cause`) USING BTREE;

ALTER TABLE `operation`
  ADD KEY `index_operation` (`operation`);

ALTER TABLE `operation_category`
  ADD KEY `index_category` (`category`);

ALTER TABLE `operation_theatre`
  ADD KEY `index_date` (`date`);

ALTER TABLE `organisation`
  ADD KEY `index_organisation_name` (`organisation_name`),
  ADD KEY `index_code` (`code`),
  ADD KEY `index_contact_no` (`contact_no`),
  ADD KEY `index_address` (`address`),
  ADD KEY `index_contact_person_name` (`contact_person_name`),
  ADD KEY `index_contact_person_phone` (`contact_person_phone`);

ALTER TABLE `pathology`
  ADD KEY `index_test_name` (`test_name`),
  ADD KEY `index_short_name` (`short_name`),
  ADD KEY `index_test_type` (`test_type`),
  ADD KEY `index_unit` (`unit`),
  ADD KEY `index_sub_category` (`sub_category`),
  ADD KEY `index_report_days` (`report_days`),
  ADD KEY `index_method` (`method`);

ALTER TABLE `pathology_billing`
  ADD KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_doctor_name` (`doctor_name`),
  ADD KEY `index_total` (`total`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_discount` (`discount`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_net_amount` (`net_amount`),
  ADD KEY `organisation_id` (`organisation_id`);

ALTER TABLE `pathology_category`
  ADD KEY `index_category_name` (`category_name`);

ALTER TABLE `pathology_parameter`
  ADD KEY `index_parameter_name` (`parameter_name`),
  ADD KEY `index_test_value` (`test_value`),
  ADD KEY `index_reference_range` (`reference_range`),
  ADD KEY `index_range_from` (`range_from`),
  ADD KEY `index_range_to` (`range_to`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_unit` (`unit`);

ALTER TABLE `pathology_report`
  ADD KEY `index_reporting_date` (`reporting_date`),
  ADD KEY `index_parameter_update` (`parameter_update`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_apply_charge` (`apply_charge`),
  ADD KEY `index_collection_date` (`collection_date`);

ALTER TABLE `patients`
  ADD KEY `idx_patient_name` (`patient_name`),
  ADD KEY `idx_dob` (`dob`),
  ADD KEY `idx_age` (`age`),
  ADD KEY `idx_month` (`month`),
  ADD KEY `idx_mobileno` (`mobileno`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_gender` (`gender`),
  ADD KEY `idx_marital_status` (`marital_status`),
  ADD KEY `idx_address` (`address`(500)),
  ADD KEY `idx_guardian_name` (`guardian_name`),
  ADD KEY `organisation_id` (`organisation_id`);

ALTER TABLE `patients_vitals`
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `index_reference_range` (`reference_range`),
  ADD KEY `index_messure_date` (`messure_date`),
  ADD KEY `vital_id` (`vital_id`);

ALTER TABLE `patient_bed_history`
  ADD KEY `index_from_date` (`from_date`),
  ADD KEY `index_to_date` (`to_date`);

ALTER TABLE `patient_charges`
  ADD KEY `organisation_id` (`organisation_id`),
  ADD KEY `index_qty` (`qty`),
  ADD KEY `index_standard_charge` (`standard_charge`),
  ADD KEY `index_tpa_charge` (`tpa_charge`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_apply_charge` (`apply_charge`),
  ADD KEY `index_amount` (`amount`);

ALTER TABLE `patient_id_card`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_hospital_name` (`hospital_name`),
  ADD KEY `index_hospital_address` (`hospital_address`),
  ADD KEY `index_header_color` (`header_color`),
  ADD KEY `index_enable_patient_name` (`enable_patient_name`),
  ADD KEY `index_enable_guardian_name` (`enable_guardian_name`),
  ADD KEY `index_enable_patient_unique_id` (`enable_patient_unique_id`),
  ADD KEY `index_enable_address` (`enable_address`),
  ADD KEY `index_enable_phone` (`enable_phone`),
  ADD KEY `index_enable_dob` (`enable_dob`),
  ADD KEY `index_enable_blood_group` (`enable_blood_group`),
  ADD KEY `index_status` (`status`),
  ADD KEY `index_enable_barcode` (`enable_barcode`);

ALTER TABLE `patient_timeline`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_timeline_date` (`timeline_date`);

ALTER TABLE `payment_settings`
  ADD KEY `index_payment_type` (`payment_type`),
  ADD KEY `index_api_username` (`api_username`),
  ADD KEY `index_api_secret_key` (`api_secret_key`),
  ADD KEY `index_salt` (`salt`),
  ADD KEY `index_api_publishable_key` (`api_publishable_key`),
  ADD KEY `index_paytm_website` (`paytm_website`),
  ADD KEY `index_paytm_industrytype` (`paytm_industrytype`),
  ADD KEY `index_api_password` (`api_password`),
  ADD KEY `index_api_signature` (`api_signature`),
  ADD KEY `index_api_email` (`api_email`),
  ADD KEY `index_paypal_demo` (`paypal_demo`),
  ADD KEY `index_account_no` (`account_no`),
  ADD KEY `index_is_active` (`is_active`);

ALTER TABLE `payslip_allowance`
  ADD KEY `index_allowance_type` (`allowance_type`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_cal_type` (`cal_type`);

ALTER TABLE `permission_category`
  ADD KEY `index_name` (`name`);

ALTER TABLE `permission_group`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_short_code` (`short_code`);

ALTER TABLE `permission_patient`
  ADD KEY `index_permission_group_short_code` (`permission_group_short_code`),
  ADD KEY `index_name` (`name`),
  ADD KEY `index_short_code` (`short_code`),
  ADD KEY `index_is_active` (`is_active`);

ALTER TABLE `pharmacy`
  ADD KEY `idx_medicine_name` (`medicine_name`),
  ADD KEY `index_medicine_name` (`medicine_name`),
  ADD KEY `index_medicine_company` (`medicine_company`),
  ADD KEY `index_medicine_composition` (`medicine_composition`),
  ADD KEY `index_medicine_group` (`medicine_group`),
  ADD KEY `index_unit` (`unit`),
  ADD KEY `index_min_level` (`min_level`),
  ADD KEY `index_reorder_level` (`reorder_level`),
  ADD KEY `index_vat` (`vat`),
  ADD KEY `index_unit_packing` (`unit_packing`),
  ADD KEY `index_vat_ac` (`vat_ac`),
  ADD KEY `index_rack_number` (`rack_number`);

ALTER TABLE `pharmacy_bill_basic`
  ADD KEY `index_customer_name` (`customer_name`),
  ADD KEY `index_customer_type` (`customer_type`),
  ADD KEY `index_doctor_name` (`doctor_name`),
  ADD KEY `index_total` (`total`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_discount` (`discount`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_net_amount` (`net_amount`);

ALTER TABLE `pharmacy_bill_detail`
  ADD KEY `index_quantity` (`quantity`),
  ADD KEY `index_sale_price` (`sale_price`),
  ADD KEY `index_amount` (`amount`);

ALTER TABLE `pharmacy_company`
  ADD KEY `index_company_name` (`company_name`);

ALTER TABLE `postnatal_examine`
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `index_labor_time` (`labor_time`),
  ADD KEY `index_delivery_time` (`delivery_time`);

ALTER TABLE `prefixes`
  ADD KEY `index_prefix` (`prefix`);

ALTER TABLE `primary_examine`
  ADD KEY `visit_details_id` (`visit_details_id`),
  ADD KEY `ipdid` (`ipdid`),
  ADD KEY `index_bleeding` (`bleeding`),
  ADD KEY `index_headache` (`headache`),
  ADD KEY `index_pain` (`pain`),
  ADD KEY `index_constipation` (`constipation`),
  ADD KEY `index_urinary_symptoms` (`urinary_symptoms`),
  ADD KEY `index_vomiting` (`vomiting`),
  ADD KEY `index_cough` (`cough`),
  ADD KEY `index_vaginal` (`vaginal`),
  ADD KEY `index_discharge` (`discharge`),
  ADD KEY `index_oedema` (`oedema`),
  ADD KEY `index_haemoroids` (`haemoroids`),
  ADD KEY `index_weight` (`weight`),
  ADD KEY `index_height` (`height`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `radio`
  ADD KEY `index_test_name` (`test_name`),
  ADD KEY `index_short_name` (`short_name`),
  ADD KEY `index_test_type` (`test_type`);

ALTER TABLE `radiology_billing`
  ADD KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_doctor_name` (`doctor_name`),
  ADD KEY `index_total` (`total`),
  ADD KEY `index_discount_percentage` (`discount_percentage`),
  ADD KEY `index_discount` (`discount`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_net_amount` (`net_amount`),
  ADD KEY `index_transaction_id` (`transaction_id`),
  ADD KEY `index_organisation_id` (`organisation_id`),
  ADD KEY `index_insurance_validity` (`insurance_validity`),
  ADD KEY `index_insurance_id` (`insurance_id`);

ALTER TABLE `radiology_parameter`
  ADD KEY `index_parameter_name` (`parameter_name`),
  ADD KEY `index_test_value` (`test_value`),
  ADD KEY `index_reference_range` (`reference_range`),
  ADD KEY `index_range_from` (`range_from`),
  ADD KEY `index_range_to` (`range_to`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_unit` (`unit`);

ALTER TABLE `radiology_report`
  ADD KEY `index_customer_type` (`customer_type`),
  ADD KEY `index_patient_name` (`patient_name`),
  ADD KEY `index_consultant_doctor` (`consultant_doctor`),
  ADD KEY `index_reporting_date` (`reporting_date`),
  ADD KEY `index_parameter_update` (`parameter_update`),
  ADD KEY `index_tax_percentage` (`tax_percentage`),
  ADD KEY `index_apply_charge` (`apply_charge`),
  ADD KEY `index_radiology_center` (`radiology_center`);

ALTER TABLE `referral_category`
  ADD KEY `index_name` (`name`);

ALTER TABLE `referral_payment`
  ADD KEY `index_bill_amount` (`bill_amount`),
  ADD KEY `index_percentage` (`percentage`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `referral_person`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_contact` (`contact`),
  ADD KEY `index_person_name` (`person_name`),
  ADD KEY `index_person_phone` (`person_phone`),
  ADD KEY `index_standard_commission` (`standard_commission`);

ALTER TABLE `referral_type`
  ADD KEY `index_name` (`name`),
  ADD KEY `index_prefixes_type` (`prefixes_type`);

ALTER TABLE `roles`
  ADD KEY `index_name` (`name`);

ALTER TABLE `roles_permissions`
  ADD KEY `index_can_view` (`can_view`),
  ADD KEY `index_can_add` (`can_add`),
  ADD KEY `index_can_edit` (`can_edit`),
  ADD KEY `index_can_delete` (`can_delete`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `perm_cat_id` (`perm_cat_id`);

ALTER TABLE `send_notification`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_publish_date` (`publish_date`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_visible_staff` (`visible_staff`),
  ADD KEY `index_visible_patient` (`visible_patient`);

ALTER TABLE `share_contents`
  ADD KEY `created_by` (`created_by`),
  ADD KEY `index_send_to` (`send_to`),
  ADD KEY `index_share_date` (`share_date`),
  ADD KEY `index_valid_upto` (`valid_upto`),
  ADD KEY `index_created_by` (`created_by`);

ALTER TABLE `share_content_for`
  ADD KEY `upload_content_id` (`share_content_id`),
  ADD KEY `student_id` (`patient_id`),
  ADD KEY `staff_id` (`staff_id`);

ALTER TABLE `share_upload_contents`
  ADD KEY `upload_content_id` (`upload_content_id`),
  ADD KEY `share_content_id` (`share_content_id`);

ALTER TABLE `shift_details`
  ADD KEY `index_consult_duration` (`consult_duration`);

ALTER TABLE `source`
  ADD KEY `index_source` (`source`);

ALTER TABLE `specialist`
  ADD KEY `index_specialist_name` (`specialist_name`);

ALTER TABLE `staff`
  ADD KEY `staff_designation_id` (`staff_designation_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `index_name` (`name`),
  ADD KEY `index_surname` (`surname`),
  ADD KEY `index_father_name` (`father_name`),
  ADD KEY `index_mother_name` (`mother_name`),
  ADD KEY `index_contact_no` (`contact_no`),
  ADD KEY `index_emergency_contact_no` (`emergency_contact_no`),
  ADD KEY `index_email` (`email`),
  ADD KEY `index_dob` (`dob`),
  ADD KEY `index_marital_status` (`marital_status`),
  ADD KEY `index_date_of_joining` (`date_of_joining`),
  ADD KEY `index_date_of_leaving` (`date_of_leaving`),
  ADD KEY `index_gender` (`gender`),
  ADD KEY `index_blood_group` (`blood_group`);

ALTER TABLE `staff_attendance_type`
  ADD KEY `index_type` (`type`),
  ADD KEY `index_key_value` (`key_value`),
  ADD KEY `index_is_active` (`is_active`),
  ADD KEY `index_long_lang_name` (`long_lang_name`),
  ADD KEY `index_long_name_style` (`long_name_style`),
  ADD KEY `index_for_schedule` (`for_schedule`);

ALTER TABLE `staff_attendence_schedules`
  ADD KEY `role_id` (`role_id`),
  ADD KEY `staff_attendence_type_id` (`staff_attendence_type_id`),
  ADD KEY `index_entry_time_from` (`entry_time_from`),
  ADD KEY `index_entry_time_to` (`entry_time_to`),
  ADD KEY `index_total_institute_hour` (`total_institute_hour`);

ALTER TABLE `staff_designation`
  ADD KEY `index_designation` (`designation`);

ALTER TABLE `staff_id_card`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_hospital_name` (`hospital_name`),
  ADD KEY `index_hospital_address` (`hospital_address`),
  ADD KEY `index_header_color` (`header_color`),
  ADD KEY `index_enable_staff_role` (`enable_staff_role`),
  ADD KEY `index_enable_staff_id` (`enable_staff_id`),
  ADD KEY `index_enable_staff_department` (`enable_staff_department`),
  ADD KEY `index_enable_designation` (`enable_designation`),
  ADD KEY `index_enable_name` (`enable_name`),
  ADD KEY `index_enable_fathers_name` (`enable_fathers_name`),
  ADD KEY `index_enable_mothers_name` (`enable_mothers_name`),
  ADD KEY `index_enable_date_of_joining` (`enable_date_of_joining`),
  ADD KEY `index_enable_permanent_address` (`enable_permanent_address`),
  ADD KEY `index_enable_staff_dob` (`enable_staff_dob`),
  ADD KEY `index_enable_staff_phone` (`enable_staff_phone`),
  ADD KEY `index_enable_staff_barcode` (`enable_staff_barcode`),
  ADD KEY `index_status` (`status`);

ALTER TABLE `staff_leave_request`
  ADD KEY `index_leave_from` (`leave_from`),
  ADD KEY `index_leave_to` (`leave_to`),
  ADD KEY `index_leave_days` (`leave_days`),
  ADD KEY `index_employee_remark` (`employee_remark`),
  ADD KEY `index_admin_remark` (`admin_remark`),
  ADD KEY `index_status` (`status`),
  ADD KEY `index_approved_date` (`approved_date`),
  ADD KEY `index_status_updated_by` (`status_updated_by`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `staff_payslip`
  ADD KEY `index_basic` (`basic`),
  ADD KEY `index_total_allowance` (`total_allowance`),
  ADD KEY `index_total_deduction` (`total_deduction`),
  ADD KEY `index_leave_deduction` (`leave_deduction`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_net_salary` (`net_salary`),
  ADD KEY `index_status` (`status`),
  ADD KEY `index_month` (`month`),
  ADD KEY `index_year` (`year`),
  ADD KEY `index_cheque_no` (`cheque_no`),
  ADD KEY `index_cheque_date` (`cheque_date`),
  ADD KEY `index_attachment` (`attachment`),
  ADD KEY `index_payment_mode` (`payment_mode`),
  ADD KEY `index_payment_date` (`payment_date`);

ALTER TABLE `staff_timeline`
  ADD KEY `index_title` (`title`),
  ADD KEY `index_timeline_date` (`timeline_date`),
  ADD KEY `index_status` (`status`),
  ADD KEY `index_date` (`date`);

ALTER TABLE `supplier_bill_basic`
  ADD KEY `index_total` (`total`),
  ADD KEY `index_tax` (`tax`),
  ADD KEY `index_discount` (`discount`),
  ADD KEY `index_net_amount` (`net_amount`),
  ADD KEY `index_payment_mode` (`payment_mode`),
  ADD KEY `index_cheque_no` (`cheque_no`),
  ADD KEY `index_cheque_date` (`cheque_date`),
  ADD KEY `index_payment_date` (`payment_date`);

ALTER TABLE `symptoms`
  ADD KEY `index_symptoms_title` (`symptoms_title`);

ALTER TABLE `symptoms_classification`
  ADD KEY `index_symptoms_type` (`symptoms_type`);

ALTER TABLE `system_notification`
  ADD KEY `idx_notification_title` (`notification_title`);

ALTER TABLE `system_notification_setting`
  ADD KEY `index_event` (`event`),
  ADD KEY `index_is_staff` (`is_staff`),
  ADD KEY `index_is_patient` (`is_patient`);

ALTER TABLE `tax_category`
  ADD KEY `index_name` (`name`);

ALTER TABLE `transactions`
  ADD KEY `bill_id` (`bill_id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_patient_id` (`patient_id`),
  ADD KEY `index_type` (`type`),
  ADD KEY `index_section` (`section`);

ALTER TABLE `transactions_processing`
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `case_reference_id` (`case_reference_id`),
  ADD KEY `opd_id` (`opd_id`),
  ADD KEY `ipd_id` (`ipd_id`),
  ADD KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  ADD KEY `pathology_billing_id` (`pathology_billing_id`),
  ADD KEY `radiology_billing_id` (`radiology_billing_id`),
  ADD KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  ADD KEY `blood_issue_id` (`blood_issue_id`),
  ADD KEY `ambulance_call_id` (`ambulance_call_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `bill_id` (`bill_id`),
  ADD KEY `index_attachment` (`attachment`),
  ADD KEY `index_amount_type` (`amount_type`),
  ADD KEY `index_amount` (`amount`),
  ADD KEY `index_payment_mode` (`payment_mode`),
  ADD KEY `index_cheque_no` (`cheque_no`),
  ADD KEY `index_cheque_date` (`cheque_date`),
  ADD KEY `index_payment_date` (`payment_date`);

ALTER TABLE `unit`
  ADD KEY `index_unit_name` (`unit_name`),
  ADD KEY `index_unit_type` (`unit_type`);

ALTER TABLE `upload_contents`
  ADD KEY `upload_by` (`upload_by`),
  ADD KEY `upload_contents_ibfk_2` (`content_type_id`);

ALTER TABLE `vehicles`
  ADD KEY `index_vehicle_no` (`vehicle_no`),
  ADD KEY `index_vehicle_model` (`vehicle_model`),
  ADD KEY `index_manufacture_year` (`manufacture_year`),
  ADD KEY `index_vehicle_type` (`vehicle_type`),
  ADD KEY `index_driver_name` (`driver_name`),
  ADD KEY `index_driver_licence` (`driver_licence`),
  ADD KEY `index_driver_contact` (`driver_contact`);

ALTER TABLE `visitors_book`
  ADD KEY `index_source` (`source`),
  ADD KEY `index_purpose` (`purpose`),
  ADD KEY `index_name` (`name`),
  ADD KEY `index_email` (`email`),
  ADD KEY `index_contact` (`contact`),
  ADD KEY `index_id_proof` (`id_proof`),
  ADD KEY `index_visit_to` (`visit_to`),
  ADD KEY `index_related_to` (`related_to`),
  ADD KEY `index_no_of_pepple` (`no_of_pepple`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_in_time` (`in_time`),
  ADD KEY `index_out_time` (`out_time`);

ALTER TABLE `visitors_purpose`
  ADD KEY `index_visitors_purpose` (`visitors_purpose`);

ALTER TABLE `visit_details`
  ADD KEY `index_case_type` (`case_type`),
  ADD KEY `index_appointment_date` (`appointment_date`),
  ADD KEY `index_symptoms_type` (`symptoms_type`),
  ADD KEY `index_bp` (`bp`),
  ADD KEY `index_height` (`height`),
  ADD KEY `index_weight` (`weight`),
  ADD KEY `index_pulse` (`pulse`),
  ADD KEY `index_temperature` (`temperature`),
  ADD KEY `index_respiration` (`respiration`),
  ADD KEY `index_known_allergies` (`known_allergies`),
  ADD KEY `index_patient_old` (`patient_old`),
  ADD KEY `index_casualty` (`casualty`),
  ADD KEY `index_refference` (`refference`),
  ADD KEY `index_date` (`date`),
  ADD KEY `index_payment_mode` (`payment_mode`),
  ADD KEY `index_generated_by` (`generated_by`),
  ADD KEY `index_live_consult` (`live_consult`),
  ADD KEY `index_is_antenatal` (`is_antenatal`);

ALTER TABLE `vitals`
  ADD KEY `unit` (`unit`),
  ADD KEY `index_name` (`name`),
  ADD KEY `index_reference_range` (`reference_range`),
  ADD KEY `index_unit` (`unit`),
  ADD KEY `index_is_system` (`is_system`);

ALTER TABLE `ambulance_call`
  ADD CONSTRAINT `ambulance_call_ibfk_6` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE;

ALTER TABLE `antenatal_examine`
  ADD CONSTRAINT `antenatal_examine_ibfk_1` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `antenatal_examine_ibfk_2` FOREIGN KEY (`ipdid`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `antenatal_examine_ibfk_3` FOREIGN KEY (`primary_examine_id`) REFERENCES `primary_examine` (`id`) ON DELETE CASCADE; 

ALTER TABLE `bed`
  ADD CONSTRAINT `bed_ibfk_3` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE;

ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE;

ALTER TABLE `blood_issue`
  ADD CONSTRAINT `blood_issue_ibfk_5` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_issue_ibfk_6` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_issue_ibfk_7` FOREIGN KEY (`hospital_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `case_references`
  ADD CONSTRAINT `case_references_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE `duty_roster_assign`
  ADD CONSTRAINT `duty_roster_assign_ibfk_1` FOREIGN KEY (`duty_roster_list_id`) REFERENCES `duty_roster_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `duty_roster_assign_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `duty_roster_assign_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `duty_roster_assign_ibfk_4` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`id`) ON DELETE CASCADE;

ALTER TABLE `duty_roster_list`
  ADD CONSTRAINT `duty_roster_list_ibfk_1` FOREIGN KEY (`duty_roster_shift_id`) REFERENCES `duty_roster_shift` (`id`) ON DELETE CASCADE;

ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

ALTER TABLE `gateway_ins`
  ADD CONSTRAINT `gateway_ins_ibfk_1` FOREIGN KEY (`online_appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE;

ALTER TABLE `gateway_ins_response`
  ADD CONSTRAINT `gateway_ins_response_ibfk_1` FOREIGN KEY (`gateway_ins_id`) REFERENCES `gateway_ins` (`id`) ON DELETE CASCADE;

ALTER TABLE `ipd_details`
  ADD CONSTRAINT `ipd_details_ibfk_6` FOREIGN KEY (`bed`) REFERENCES `bed` (`id`) ON DELETE CASCADE;

ALTER TABLE `ipd_prescription_basic`
  ADD CONSTRAINT `ipd_prescription_basic_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ipd_prescription_basic_ibfk_4` FOREIGN KEY (`prescribe_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `ipd_prescription_details`
  ADD CONSTRAINT `ipd_prescription_details_ibfk_3` FOREIGN KEY (`dose_interval_id`) REFERENCES `dose_interval` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ipd_prescription_details_ibfk_4` FOREIGN KEY (`dose_duration_id`) REFERENCES `dose_interval` (`id`) ON DELETE CASCADE;

ALTER TABLE `medication_report`
  ADD CONSTRAINT `medication_report_ibfk_5` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE;

ALTER TABLE `medicine_bad_stock`
  ADD CONSTRAINT `medicine_bad_stock_ibfk_2` FOREIGN KEY (`medicine_batch_details_id`) REFERENCES `medicine_batch_details` (`id`) ON DELETE CASCADE;

ALTER TABLE `pathology_billing`
  ADD CONSTRAINT `pathology_billing_ibfk_6` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pathology_billing_ibfk_7` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE;

ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE;

ALTER TABLE `patients_vitals`
  ADD CONSTRAINT `patients_vitals_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patients_vitals_ibfk_2` FOREIGN KEY (`vital_id`) REFERENCES `vitals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patients_vitals_ibfk_3` FOREIGN KEY (`vital_id`) REFERENCES `vitals` (`id`) ON DELETE CASCADE;

ALTER TABLE `patient_charges`
  ADD CONSTRAINT `patient_charges_ibfk_4` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE;

ALTER TABLE `patient_timeline`
  ADD CONSTRAINT `patient_timeline_ibfk_2` FOREIGN KEY (`generated_users_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `postnatal_examine`
  ADD CONSTRAINT `postnatal_examine_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

ALTER TABLE `primary_examine`
  ADD CONSTRAINT `primary_examine_ibfk_1` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `primary_examine_ibfk_2` FOREIGN KEY (`ipdid`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE;

ALTER TABLE `radiology_billing`
  ADD CONSTRAINT `radiology_billing_ibfk_6` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `radiology_billing_ibfk_7` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE;

ALTER TABLE `share_contents`
  ADD CONSTRAINT `share_contents_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `share_upload_contents`
  ADD CONSTRAINT `share_upload_contents_ibfk_1` FOREIGN KEY (`upload_content_id`) REFERENCES `upload_contents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `share_upload_contents_ibfk_2` FOREIGN KEY (`share_content_id`) REFERENCES `share_contents` (`id`) ON DELETE CASCADE;

ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`staff_designation_id`) REFERENCES `staff_designation` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE;

ALTER TABLE `staff_attendence_schedules`
  ADD CONSTRAINT `staff_attendence_schedules_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_attendence_schedules_ibfk_2` FOREIGN KEY (`staff_attendence_type_id`) REFERENCES `staff_attendance_type` (`id`) ON DELETE CASCADE;

ALTER TABLE `medicine_dosage`
    ADD CONSTRAINT `medicine_dosage_ibfk_2` FOREIGN KEY (`units_id`) REFERENCES `unit` (`id`) ON DELETE CASCADE;

ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_12` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`) ON DELETE CASCADE;

ALTER TABLE `transactions_processing`
  ADD CONSTRAINT `transactions_processing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_10` FOREIGN KEY (`ambulance_call_id`) REFERENCES `ambulance_call` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_11` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_12` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_3` FOREIGN KEY (`opd_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_4` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_5` FOREIGN KEY (`pharmacy_bill_basic_id`) REFERENCES `pharmacy_bill_basic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_6` FOREIGN KEY (`pathology_billing_id`) REFERENCES `pathology_billing` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_7` FOREIGN KEY (`radiology_billing_id`) REFERENCES `radiology_billing` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_8` FOREIGN KEY (`blood_donor_cycle_id`) REFERENCES `blood_donor_cycle` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_processing_ibfk_9` FOREIGN KEY (`blood_issue_id`) REFERENCES `blood_issue` (`id`) ON DELETE CASCADE;

ALTER TABLE `upload_contents`
  ADD CONSTRAINT `upload_contents_ibfk_1` FOREIGN KEY (`upload_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upload_contents_ibfk_2` FOREIGN KEY (`content_type_id`) REFERENCES `content_types` (`id`) ON DELETE CASCADE;

ALTER TABLE bed_group
 MODIFY   `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;
 
ALTER TABLE bill
 MODIFY `attachment` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE custom_field_values
 MODIFY   `field_value` varchar(500) DEFAULT NULL;

ALTER TABLE death_report
 MODIFY   `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL; 
 
ALTER TABLE contents
 MODIFY `file` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE dispatch_receive
 MODIFY `date` date DEFAULT NULL;
 
ALTER TABLE expenses
 MODIFY   `documents` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE front_cms_programs
 MODIFY `feature_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE front_cms_settings
 MODIFY `logo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE income
 MODIFY `documents` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE ipd_prescription_basic
 MODIFY `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE item
 MODIFY `item_photo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE item_stock
 MODIFY `attachment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE nurse_note
MODIFY  `note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE nurse_notes_comment
MODIFY `created_at` datetime DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE patients
MODIFY `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;

ALTER TABLE pharmacy
MODIFY   `medicine_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL;

ALTER TABLE `patient_id_card`
  MODIFY `background` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  MODIFY `logo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  MODIFY `sign_image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL; 

ALTER TABLE `roles_permissions`
  ADD CONSTRAINT `roles_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `roles_permissions_ibfk_2` FOREIGN KEY (`perm_cat_id`) REFERENCES `permission_category` (`id`) ON DELETE CASCADE;

ALTER TABLE `appointment`
DROP COLUMN time;

ALTER TABLE `appointment`
  ADD KEY `visit_details_id` (`visit_details_id`),
  ADD KEY `doctor_shift_time_id` (`doctor_shift_time_id`);

ALTER TABLE `doctor_shift_time`
  DROP KEY `global_shift_id`;

ALTER TABLE `doctor_shift_time`
  ADD KEY `doctor_global_shift_id` (`doctor_global_shift_id`),
  ADD KEY `index_day` (`day`);

ALTER TABLE `medicine_group`
  ADD KEY `index_group_name` (`group_name`);

ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_4` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_5` FOREIGN KEY (`doctor_shift_time_id`) REFERENCES `doctor_shift_time` (`id`) ON DELETE CASCADE;  

ALTER TABLE `share_content_for`
  ADD CONSTRAINT `share_content_for_ibfk_1` FOREIGN KEY (`share_content_id`) REFERENCES `share_contents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `share_content_for_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patient_id` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `share_content_for_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

ALTER TABLE `doctor_shift_time`
    ADD CONSTRAINT `doctor_shift_time_ibfk_3` FOREIGN KEY (`doctor_global_shift_id`) REFERENCES `doctor_global_shift` (`id`) ON DELETE CASCADE;
	
SET foreign_key_checks = 1;
