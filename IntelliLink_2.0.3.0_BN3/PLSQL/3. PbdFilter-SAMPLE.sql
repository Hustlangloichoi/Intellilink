-------------------------------------------------------------------------------------------------
--	Copyright (c) INFINITT Co., Ltd.
--	All Rights Reserved
-------------------------------------------------------------------------------------------------

CREATE OR REPLACE
PACKAGE BODY sp_filter
AS

-------------------------------------------------------------------------------------------------
-- call procedure for ODBC BROKER
-- Use with PBMFilter for G3
-------------------------------------------------------------------------------------------------
	PROCEDURE adt_to_patient
	(
		v_a_broker_aetitle				IN VARCHAR2,
		v_a_event_type					IN VARCHAR2,
		v_a_patient_account_no			IN VARCHAR2,
		v_a_patient_id					IN VARCHAR2,
		v_a_patient_name				IN VARCHAR2,
		v_a_patient_ename				IN VARCHAR2,
		v_a_patient_ssn					IN VARCHAR2,
		v_a_patient_birth_dttm			IN VARCHAR2,
		v_a_patient_sex					IN VARCHAR2,
		v_a_patient_ethnic_group		IN VARCHAR2,
		v_a_patient_phone_no			IN VARCHAR2,
		v_a_patient_email				IN VARCHAR2,
		v_a_patient_address				IN VARCHAR2,
		v_a_patient_fax_no				IN VARCHAR2,
		v_a_patient_zipcode				IN VARCHAR2,
		v_a_patient_class				IN VARCHAR2,
		v_a_patient_location			IN VARCHAR2,
		v_a_current_doctor_id			IN VARCHAR2,
		v_a_current_doctor_name			IN VARCHAR2,
		v_a_prior_patient_location		IN VARCHAR2,
		v_a_prior_patient_id			IN VARCHAR2,
		v_a_patient_weight				IN VARCHAR2,
		v_a_patient_size				IN VARCHAR2,
		v_a_patient_blood_type			IN VARCHAR2,
		v_a_patient_pregnancy_status	IN VARCHAR2,
		v_a_adt_field1					IN VARCHAR2,
		v_a_adt_field2					IN VARCHAR2,
		v_a_adt_field3					IN VARCHAR2,
		v_a_adt_field4					IN VARCHAR2,
		v_a_adt_field5					IN VARCHAR2,
		v_a_adt_field6					IN VARCHAR2,
		v_a_adt_field7					IN VARCHAR2,
		v_a_adt_field8					IN VARCHAR2,
		v_a_adt_field9					IN VARCHAR2,
		v_a_adt_field10					IN VARCHAR2,

		v_p_event_type					OUT VARCHAR2,
		v_p_patient_id					OUT VARCHAR2,
		v_p_prior_patient_id			OUT VARCHAR2,
		v_p_patient_name				OUT VARCHAR2,
		v_p_english_name				OUT VARCHAR2,
		v_p_patient_ssn					OUT VARCHAR2,
		v_p_patient_birth_dttm			OUT VARCHAR2,
		v_p_patient_sex					OUT VARCHAR2,
		v_p_patient_weight				OUT VARCHAR2,
		v_p_patient_size				OUT VARCHAR2,
		v_p_ethnic_group				OUT VARCHAR2,
		v_p_tel_no						OUT VARCHAR2,
		v_p_fax_no						OUT VARCHAR2,
		v_p_zipcode						OUT VARCHAR2,
		v_p_address						OUT VARCHAR2,
		v_p_email						OUT VARCHAR2,
		v_p_blood_type					OUT VARCHAR2,
		v_p_pregnancy_status			OUT VARCHAR2,
		v_p_current_location			OUT VARCHAR2,
		v_p_current_residency			OUT VARCHAR2,
		v_p_current_department			OUT VARCHAR2,
		v_p_current_doctor_id			OUT VARCHAR2,
		v_p_current_doctor_name			OUT VARCHAR2,
		v_p_admit_dttm					OUT VARCHAR2,
		v_p_discharge_dttm				OUT VARCHAR2,
		v_p_patient_id_issuer			OUT VARCHAR2,
		v_p_last_name					OUT VARCHAR2,
		v_p_first_name					OUT VARCHAR2,
		v_p_middle_name					OUT VARCHAR2,
		v_p_prefix						OUT VARCHAR2,
		v_p_suffix						OUT VARCHAR2,
		v_p_marital_status				OUT VARCHAR2,
		v_p_confidentiality				OUT VARCHAR2,
		v_p_patient_death_dttm			OUT VARCHAR2,
		v_p_blood_type_rh				OUT VARCHAR2,
		v_p_citizenship					OUT VARCHAR2,
		v_p_occupation					OUT VARCHAR2,
		v_p_race_code					OUT VARCHAR2,
		v_p_language_code				OUT VARCHAR2,
		v_p_religion_code				OUT VARCHAR2,
		v_p_birth_place					OUT VARCHAR2,
		v_p_multiple_birth_status		OUT VARCHAR2,
		v_p_birth_order					OUT VARCHAR2,
		v_p_cell_phone_no				OUT VARCHAR2,
		v_p_pregnancy_code				OUT VARCHAR2,
		v_p_patient_status				OUT VARCHAR2,
		v_p_account_number				OUT VARCHAR2,
		v_p_contact_type				OUT VARCHAR2,
		v_p_business_phone_no			OUT VARCHAR2,
		v_p_city						OUT VARCHAR2,
		v_p_state						OUT VARCHAR2,
		v_p_country						OUT VARCHAR2,
		v_p_visit_number				OUT VARCHAR2,
		v_p_visit_status				OUT VARCHAR2,
		v_p_consult_doctor_id			OUT VARCHAR2,
		v_p_institution_code			OUT VARCHAR2,
		v_p_visit_comments				OUT VARCHAR2,
		v_p_admit_route					OUT VARCHAR2,
		v_p_last_menstrual_dttm			OUT VARCHAR2,
		v_p_code_abbreviation			OUT VARCHAR2,
		v_p_station_code				OUT VARCHAR2,
		v_p_consult_doctor_name			OUT VARCHAR2,
		v_p_broker_aetitle				OUT VARCHAR2,
		v_p_broker_type					OUT VARCHAR2
	)
	IS
	BEGIN
		v_p_event_type					:= substr(v_a_event_type, 1, 32);
		v_p_patient_id					:= substr(v_a_patient_id, 1, 32);
		v_p_prior_patient_id			:= substr(v_a_prior_patient_id, 1, 64);
		v_p_patient_name				:= substr(v_a_patient_name, 1, 32);
		v_p_english_name				:= substr(v_a_patient_ename, 1, 32);
		v_p_patient_ssn					:= substr(v_a_patient_ssn, 1, 32);
		v_p_patient_birth_dttm			:= substr(v_a_patient_birth_dttm, 1, 32);
		v_p_patient_sex					:= substr(v_a_patient_sex, 1, 32);
		v_p_patient_weight				:= substr(v_a_patient_weight, 1, 32);
		v_p_patient_size				:= substr(v_a_patient_size, 1, 32);
		v_p_ethnic_group				:= substr(v_a_patient_ethnic_group, 1, 32);
		v_p_tel_no						:= substr(v_a_patient_phone_no, 1, 32);
		v_p_fax_no						:= substr(v_a_patient_fax_no, 1, 32);
		v_p_zipcode						:= substr(v_a_patient_zipcode, 1, 32);
		v_p_address						:= substr(v_a_patient_address, 1, 32);
		v_p_email						:= substr(v_a_patient_email, 1, 32);
		v_p_blood_type					:= substr(v_a_patient_blood_type, 1, 32);
		v_p_pregnancy_status			:= substr(v_a_patient_pregnancy_status, 1, 32);
		v_p_current_location			:= substr(v_a_patient_class, 1, 32);
		v_p_current_residency			:= substr(v_a_patient_location, 1, 32);
		v_p_current_department			:= substr(v_a_prior_patient_location, 1, 32);
		v_p_current_doctor_id			:= substr(v_a_current_doctor_id, 1, 32);
		v_p_current_doctor_name			:= substr(v_a_current_doctor_name, 1, 32);
		v_p_admit_dttm					:= NULL;
		v_p_discharge_dttm				:= NULL;

		v_p_patient_id_issuer			:= NULL;
		v_p_last_name					:= NULL;
		v_p_first_name					:= NULL;
		v_p_middle_name					:= NULL;
		v_p_prefix						:= NULL;
		v_p_suffix						:= NULL;
		v_p_marital_status				:= NULL;
		v_p_confidentiality				:= NULL;
		v_p_patient_death_dttm			:= NULL;
		v_p_blood_type_rh				:= NULL;
		v_p_citizenship					:= NULL;
		v_p_occupation					:= NULL;
		v_p_race_code					:= NULL;
		v_p_language_code				:= NULL;
		v_p_religion_code				:= NULL;
		v_p_birth_place					:= NULL;
		v_p_multiple_birth_status		:= NULL;
		v_p_birth_order					:= NULL;
		v_p_cell_phone_no				:= NULL;
		v_p_pregnancy_code				:= NULL;
		v_p_patient_status				:= NULL;
		v_p_account_number				:= NULL;
		v_p_contact_type				:= NULL;
		v_p_business_phone_no			:= NULL;
		v_p_city						:= NULL;
		v_p_state						:= NULL;
		v_p_country						:= NULL;
		v_p_visit_number				:= NULL;
		v_p_visit_status				:= NULL;
		v_p_consult_doctor_id			:= NULL;
		v_p_institution_code			:= NULL;
		v_p_visit_comments				:= NULL;
		v_p_admit_route					:= NULL;
		v_p_last_menstrual_dttm			:= NULL;
		v_p_code_abbreviation			:= NULL;
		v_p_station_code				:= NULL;
		v_p_consult_doctor_name			:= NULL;
		v_p_broker_aetitle				:= v_a_broker_aetitle;
		v_p_broker_type					:= 'ODBC';
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE orm_to_mwl
	(
		v_o_broker_aetitle				IN VARCHAR2,
		v_o_message_control_id			IN VARCHAR2,
		v_o_event_type					IN VARCHAR2,
		v_o_patient_account_no			IN VARCHAR2,
		v_o_patient_id					IN VARCHAR2,
		v_o_patient_name				IN VARCHAR2,
		v_o_patient_ename				IN VARCHAR2,
		v_o_patient_ssn					IN VARCHAR2,
		v_o_patient_birth_dttm			IN VARCHAR2,
		v_o_patient_sex					IN VARCHAR2,
		v_o_refering_doctor_id			IN VARCHAR2,
		v_o_refering_doctor_name		IN VARCHAR2,
		v_o_attending_doctor_id			IN VARCHAR2,
		v_o_attending_doctor_name		IN VARCHAR2,
		v_o_prior_patient_location		IN VARCHAR2,
		v_o_consulting_doctor_id		IN VARCHAR2,
		v_o_consulting_doctor_name		IN VARCHAR2,
		v_o_patient_class				IN VARCHAR2,
		v_o_scheduled_date_time			IN VARCHAR2,
		v_o_filler_order_no				IN VARCHAR2,
		v_o_quantity_timing				IN VARCHAR2,
		v_o_order_control_id			IN VARCHAR2,
		v_o_universal_service_id		IN VARCHAR2,
		v_o_specimen_source				IN VARCHAR2,
		v_o_diagnostic_serv_sect_id		IN VARCHAR2,
		v_o_placer_field1				IN VARCHAR2,
		v_o_placer_field2				IN VARCHAR2,
		v_o_filler_field1				IN VARCHAR2,
		v_o_filler_field2				IN VARCHAR2,
		v_o_reason_for_study			IN VARCHAR2,
		v_o_entering_organization		IN VARCHAR2,
		v_o_reference_pointer			IN VARCHAR2,
		v_o_request_dttm				IN VARCHAR2,
		v_o_specialty					IN VARCHAR2,
		v_o_diagnosis					IN VARCHAR2,
		v_o_patient_residency			IN VARCHAR2,
		v_o_orm_field1					IN VARCHAR2,
		v_o_orm_field2					IN VARCHAR2,
		v_o_orm_field3					IN VARCHAR2,
		v_o_orm_field4					IN VARCHAR2,
		v_o_orm_field5					IN VARCHAR2,
		v_o_orm_field6					IN VARCHAR2,
		v_o_orm_field7					IN VARCHAR2,
		v_o_orm_field8					IN VARCHAR2,
		v_o_orm_field9					IN VARCHAR2,
		v_o_orm_field10					IN VARCHAR2,
		v_o_zra_field02					IN VARCHAR2,
		v_o_ipc_field01					IN VARCHAR2,
		v_o_ipc_field02					IN VARCHAR2,
		v_o_ipc_field03					IN VARCHAR2,
		v_o_ipc_field04					IN VARCHAR2,
		v_o_ipc_field05					IN VARCHAR2,
		v_o_ipc_field06					IN VARCHAR2,
		v_o_ipc_field07					IN VARCHAR2,
		v_o_ipc_field08					IN VARCHAR2,
		v_o_ipc_field09					IN VARCHAR2,

		v_m_order_control_id			OUT VARCHAR2,
		v_m_event_type					OUT VARCHAR2,
		v_m_character_set				OUT VARCHAR2,
		v_m_scheduled_aetitle			OUT VARCHAR2,
		v_m_scheduled_dttm				OUT VARCHAR2,
		v_m_scheduled_modality			OUT VARCHAR2,
		v_m_scheduled_station			OUT VARCHAR2,
		v_m_scheduled_location			OUT VARCHAR2,
		v_m_scheduled_proc_id			OUT VARCHAR2,
		v_m_scheduled_proc_desc			OUT VARCHAR2,
		v_m_scheduled_action_codes		OUT VARCHAR2,
		v_m_scheduled_proc_status		OUT VARCHAR2,
		v_m_premedication				OUT VARCHAR2,
		v_m_contrast_agent				OUT VARCHAR2,
		v_m_requested_proc_id			OUT VARCHAR2,
		v_m_requested_proc_desc			OUT VARCHAR2,
		v_m_requested_proc_codes		OUT VARCHAR2,
		v_m_requested_proc_priority		OUT VARCHAR2,
		v_m_requested_proc_reason		OUT VARCHAR2,
		v_m_requested_proc_comments		OUT VARCHAR2,
		v_m_study_instance_uid			OUT VARCHAR2,
		v_m_proc_placer_order_no		OUT VARCHAR2,
		v_m_proc_filler_order_no		OUT VARCHAR2,
		v_m_accession_no				OUT VARCHAR2,
		v_m_attend_doctor				OUT VARCHAR2,
		v_m_perform_doctor				OUT VARCHAR2,
		v_m_consult_doctor				OUT VARCHAR2,
		v_m_request_doctor				OUT VARCHAR2,
		v_m_refer_doctor				OUT VARCHAR2,
		v_m_request_department			OUT VARCHAR2,
		v_m_imaging_request_reason		OUT VARCHAR2,
		v_m_imaging_request_comments	OUT VARCHAR2,
		v_m_imaging_request_dttm		OUT VARCHAR2,
		v_m_isr_placer_order_no			OUT VARCHAR2,
		v_m_isr_filler_order_no			OUT VARCHAR2,
		v_m_admission_id				OUT VARCHAR2,
		v_m_patient_transport			OUT VARCHAR2,
		v_m_patient_location			OUT VARCHAR2,
		v_m_patient_residency			OUT VARCHAR2,
		v_m_patient_name				OUT VARCHAR2,
		v_m_patient_id					OUT VARCHAR2,
		v_m_other_patient_name			OUT VARCHAR2,
		v_m_other_patient_id			OUT VARCHAR2,
		v_m_patient_birth_dttm			OUT VARCHAR2,
		v_m_patient_sex					OUT VARCHAR2,
		v_m_patient_weight				OUT VARCHAR2,
		v_m_patient_size				OUT VARCHAR2,
		v_m_patient_state				OUT VARCHAR2,
		v_m_confidentiality				OUT VARCHAR2,
		v_m_pregnancy_status			OUT VARCHAR2,
		v_m_medical_alerts				OUT VARCHAR2,
		v_m_contrast_allergies			OUT VARCHAR2,
		v_m_special_needs				OUT VARCHAR2,
		v_m_specialty					OUT VARCHAR2,
		v_m_diagnosis					OUT VARCHAR2,
		v_m_admit_dttm					OUT VARCHAR2,
		v_m_register_dttm				OUT VARCHAR2,
		v_m_patient_id_issuer			OUT VARCHAR2,
		v_m_last_name					OUT VARCHAR2,
		v_m_first_name					OUT VARCHAR2,
		v_m_middle_name					OUT VARCHAR2,
		v_m_prefix						OUT VARCHAR2,
		v_m_suffix						OUT VARCHAR2,
		v_m_race_code					OUT VARCHAR2,
		v_m_account_no					OUT VARCHAR2,
		v_m_address						OUT VARCHAR2,
		v_m_order_entry_user_id			OUT VARCHAR2,
		v_m_order_entry_location		OUT VARCHAR2,
		v_m_order_callback_phone_no		OUT VARCHAR2,
		v_m_req_proc_status				OUT VARCHAR2,
		v_m_req_proc_code_scheme		OUT VARCHAR2,
		v_m_req_proc_code_version		OUT VARCHAR2,
		v_m_req_proc_code_meaning		OUT VARCHAR2,
		v_m_req_proc_location			OUT VARCHAR2,
		v_m_patient_arrange				OUT VARCHAR2,
		v_m_source_aetitle				OUT VARCHAR2,
		v_m_broker_aetitle				OUT VARCHAR2,
		v_m_broker_type					OUT VARCHAR2,
		v_m_study_ssn					OUT VARCHAR2
	)
	IS
	BEGIN
		v_m_order_control_id			:= v_o_order_control_id;
		v_m_event_type					:= v_o_event_type;
		v_m_character_set				:= NULL;
		v_m_scheduled_aetitle			:= 'AE';
		v_m_scheduled_dttm				:= substr(v_o_scheduled_date_time, 1, 14);
		v_m_scheduled_modality			:= substr(v_o_diagnostic_serv_sect_id, 1, 8);
		v_m_scheduled_station			:= substr(v_o_filler_field2, 1, 32);
		v_m_scheduled_location			:= substr(v_o_orm_field2, 1, 32);
		v_m_scheduled_proc_id			:= substr(v_o_filler_field1, 1, 32);
		v_m_scheduled_proc_desc			:= substr(v_o_specimen_source, 1, 64);
		v_m_scheduled_action_codes		:= substr(v_o_universal_service_id, 1, 256);
		IF v_o_order_control_id = 'CA' THEN
			v_m_scheduled_proc_status	:= '0';
		ELSE
			v_m_scheduled_proc_status	:= '120';
		END IF;
		v_m_premedication				:= NULL;
		v_m_contrast_agent				:= NULL;
		v_m_requested_proc_id			:= substr(v_o_placer_field2, 1, 32);
		--v_m_requested_proc_desc			:= substr(v_o_specimen_source, 1, 64);
		--v_m_requested_proc_codes		:= substr(v_o_universal_service_id, 1, 256);
		v_m_requested_proc_codes        := sp_util.parse_string(v_o_universal_service_id, '^', 1);
		v_m_requested_proc_desc			:= sp_util.parse_string(v_o_universal_service_id, '^', 2);
		
		v_m_requested_proc_priority		:= substr(v_o_quantity_timing, 1, 32);
		--v_m_requested_proc_reason		:= NULL;				// original
		v_m_requested_proc_reason		:= v_o_zra_field02;		-- request of IJP (2008/10/09)
		v_m_requested_proc_comments		:= v_o_reason_for_study;
		v_m_study_instance_uid			:= substr(v_o_reference_pointer, 1, 64);
		v_m_proc_placer_order_no		:= NULL;
		v_m_proc_filler_order_no		:= NULL;
		v_m_accession_no				:= substr(v_o_placer_field1, 1, 32);
		v_m_attend_doctor				:= NULL;

		--v_m_perform_doctor				:= substr(v_o_consulting_doctor_name, 1, 32);
		v_m_perform_doctor				:= substr(sp_util.parse_string(v_o_consulting_doctor_name, '^', 2), 1, 32);
		v_m_consult_doctor				:= NULL;

		--v_m_refer_doctor				:= substr(v_o_refering_doctor_name, 1, 32);
		v_m_refer_doctor				:= NVL(sp_util.parse_string(v_o_orm_field2, '^', 2), 'IHE_Doc');
				
		--v_m_request_doctor				:= substr(v_o_attending_doctor_name, 1, 32);
		v_m_request_doctor				:= NVL(substr(sp_util.parse_string(v_o_attending_doctor_name, '^', 2), 1, 32), v_m_refer_doctor);
		
		--v_m_request_department			:= substr(v_o_prior_patient_location, 1, 32);
		v_m_request_department			:= substr(NVL(v_o_prior_patient_location, 'IHE'), 1, 32);
		
		v_m_imaging_request_reason		:= NULL;
		v_m_imaging_request_comments 	:= NULL;
		v_m_imaging_request_dttm		:= substr(v_o_request_dttm, 1, 14);
		v_m_isr_placer_order_no			:= NULL;
		v_m_isr_filler_order_no			:= NULL;
		v_m_admission_id				:= substr(v_o_orm_field1, 1, 32);
		v_m_patient_transport			:= NULL;
		v_m_patient_location			:= substr(v_o_patient_class, 1, 32);
		v_m_patient_residency			:= substr(v_o_patient_residency, 1, 32);
		v_m_patient_name				:= substr(v_o_patient_name, 1, 64);
		v_m_patient_id					:= substr(v_o_patient_id, 1, 32);
		v_m_other_patient_name			:= substr(v_o_patient_ename, 1, 64);
		v_m_other_patient_id			:= substr(v_o_patient_ssn, 1, 32);
		v_m_patient_birth_dttm			:= substr(v_o_patient_birth_dttm, 1, 8);
		v_m_patient_sex					:= substr(v_o_patient_sex, 1, 1);
		v_m_patient_weight				:= NULL;
		v_m_patient_size				:= NULL;
		v_m_patient_state				:= NULL;
		v_m_confidentiality				:= NULL;
		v_m_pregnancy_status			:= NULL;
		v_m_medical_alerts	 			:= NULL;
		v_m_contrast_allergies			:= NULL;
		v_m_special_needs				:= NULL;
		v_m_specialty					:= substr(v_o_specialty, 1, 32);
		v_m_diagnosis					:= v_o_diagnosis;
		v_m_admit_dttm					:= NULL;
		v_m_register_dttm				:= NULL;

		v_m_patient_id_issuer			:= NULL;
		v_m_last_name					:= NULL;
		v_m_first_name					:= NULL;
		v_m_middle_name					:= NULL;
		v_m_prefix						:= NULL;
		v_m_suffix						:= NULL;
		v_m_race_code					:= NULL;
		v_m_account_no					:= NULL;
		v_m_address						:= NULL;
		v_m_order_entry_user_id			:= NULL;
		v_m_order_entry_location		:= NULL;
		v_m_order_callback_phone_no		:= NULL;
		v_m_req_proc_status				:= NULL;
		v_m_req_proc_code_scheme		:= NULL;
		v_m_req_proc_code_version		:= NULL;
		v_m_req_proc_code_meaning		:= NULL;
		v_m_req_proc_location			:= NULL;
		v_m_patient_arrange				:= NULL;
		v_m_source_aetitle				:= v_m_scheduled_aetitle;
		v_m_broker_aetitle				:= v_o_broker_aetitle;
		v_m_broker_type					:= 'ODBC';
		v_m_study_ssn					:= NULL;

	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE oru_to_report
	(
		v_oru_broker_aetitle			IN VARCHAR2,
		v_oru_message_control_id		IN VARCHAR2,
		v_oru_event_type				IN VARCHAR2,
		v_oru_patient_account_no		IN VARCHAR2,
		v_oru_patient_id				IN VARCHAR2,
		v_oru_patient_name				IN VARCHAR2,
		v_oru_patient_ename				IN VARCHAR2,
		v_oru_patient_ssn				IN VARCHAR2,
		v_oru_patient_birth_dttm		IN VARCHAR2,
		v_oru_patient_sex				IN VARCHAR2,
		v_oru_refering_doctor_id		IN VARCHAR2,
		v_oru_refering_doctor_name		IN VARCHAR2,
		v_oru_attending_doctor_id		IN VARCHAR2,
		v_oru_attending_doctor_name		IN VARCHAR2,
		v_oru_prior_patient_location	IN VARCHAR2,
		v_oru_consulting_doctor_id		IN VARCHAR2,
		v_oru_consulting_doctor_name	IN VARCHAR2,
		v_oru_patient_class				IN VARCHAR2,
		v_oru_scheduled_date_time		IN VARCHAR2,
		v_oru_filler_order_no			IN VARCHAR2,
		v_oru_quantity_timing			IN VARCHAR2,
		v_oru_universal_service_id		IN VARCHAR2,
		v_oru_requested_date_time		IN VARCHAR2,
		v_oru_specimen_source			IN VARCHAR2,
		v_oru_diagnostic_serv_sect_id	IN VARCHAR2,
		v_oru_placer_field1				IN VARCHAR2,
		v_oru_placer_field2				IN VARCHAR2,
		v_oru_filler_field1				IN VARCHAR2,
		v_oru_filler_field2				IN VARCHAR2,
		v_oru_reason_for_study			IN VARCHAR2,
		v_oru_observation_identifier	IN VARCHAR2,
		v_oru_observation_value			IN VARCHAR2,
		v_oru_observation_status		IN VARCHAR2,
		v_oru_observation_date_time		IN VARCHAR2,
		v_oru_responsible_observer		IN VARCHAR2,
		v_oru_field1					IN VARCHAR2,
		v_oru_field2					IN VARCHAR2,
		v_oru_field3					IN VARCHAR2,
		v_oru_field4					IN VARCHAR2,
		v_oru_field5					IN VARCHAR2,
		v_oru_field6					IN VARCHAR2,
		v_oru_field7					IN VARCHAR2,
		v_oru_field8					IN VARCHAR2,
		v_oru_field9					IN VARCHAR2,
		v_oru_field10					IN VARCHAR2,

		v_r_patient_id					OUT	VARCHAR2,
		v_r_exam_id						OUT	VARCHAR2,
		v_r_report_stat					OUT	VARCHAR2,
		v_r_creator_id					OUT	VARCHAR2,
		v_r_creator_name				OUT	VARCHAR2,
		v_r_create_dttm					OUT	VARCHAR2,
		v_r_dictator_id					OUT	VARCHAR2,
		v_r_dictator_name				OUT	VARCHAR2,
		v_r_dictate_dttm				OUT	VARCHAR2,
		v_r_transcriber_id				OUT	VARCHAR2,
		v_r_transcriber_name			OUT	VARCHAR2,
		v_r_transcribe_dttm				OUT	VARCHAR2,
		v_r_approver_id					OUT	VARCHAR2,
		v_r_approver_name				OUT	VARCHAR2,
		v_r_approve_dttm				OUT	VARCHAR2,
		v_r_reviser_id					OUT	VARCHAR2,
		v_r_reviser_name				OUT	VARCHAR2,
		v_r_revise_dttm					OUT	VARCHAR2,
		v_r_report_type					OUT	VARCHAR2,
		v_r_report_text					OUT	LONG,
		v_r_conclusion					OUT	LONG,
		v_r_event_type					OUT	VARCHAR2,
		v_r_report_control_id			OUT	VARCHAR2,
		v_r_broker_type					OUT	VARCHAR2
	)
	IS
	BEGIN
		v_r_patient_id				:= substr(v_oru_patient_id, 1, 32);
		v_r_exam_id					:= substr(v_oru_placer_field1, 1, 32);
		v_r_report_stat				:= substr(v_oru_observation_status, 1, 2);
		v_r_creator_id				:= NULL;
		v_r_creator_name			:= NULL;
		v_r_create_dttm				:= NULL;
		v_r_dictator_id				:= NULL;
		v_r_dictator_name			:= NULL;
		v_r_dictate_dttm			:= NULL;
		v_r_transcriber_id			:= NULL;
		v_r_transcriber_name		:= substr(v_oru_responsible_observer, 1, 64);
		v_r_transcribe_dttm			:= substr(v_oru_observation_date_time, 1, 14);
		v_r_approver_id				:= NULL;
		v_r_approver_name			:= substr(v_oru_responsible_observer, 1, 64);
		v_r_approve_dttm			:= substr(v_oru_observation_date_time, 1, 14);
		v_r_reviser_id				:= NULL;
		v_r_reviser_name			:= NULL;
		v_r_revise_dttm				:= NULL;
		v_r_report_type				:= NULL;
		v_r_report_text				:= v_oru_observation_value;
		v_r_conclusion				:= NULL;

		v_r_event_type				:= NULL;
		v_r_report_control_id		:= NULL;
		v_r_broker_type				:= 'ODBC';
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE patient_to_patient
	(
		v_broker_aetitle				IN OUT VARCHAR2,
		v_event_type					IN OUT VARCHAR2,
		v_patient_id					IN OUT VARCHAR2,
		v_patient_name					IN OUT VARCHAR2,
		v_english_name					IN OUT VARCHAR2,
		v_patient_ssn					IN OUT VARCHAR2,
		v_patient_birth_dttm			IN OUT VARCHAR2,
		v_patient_sex					IN OUT VARCHAR2,
		v_patient_weight				IN OUT VARCHAR2,
		v_patient_size					IN OUT VARCHAR2,
		v_ethnic_group					IN OUT VARCHAR2,
		v_tel_no						IN OUT VARCHAR2,
		v_fax_no						IN OUT VARCHAR2,
		v_zipcode						IN OUT VARCHAR2,
		v_address						IN OUT VARCHAR2,
		v_email							IN OUT VARCHAR2,
		v_blood_type					IN OUT VARCHAR2,
		v_pregnancy_status				IN OUT VARCHAR2,
		v_current_location				IN OUT VARCHAR2,
		v_current_residency				IN OUT VARCHAR2,
		v_current_department			IN OUT VARCHAR2,
		v_current_doctor_id				IN OUT VARCHAR2,
		v_current_doctor_name			IN OUT VARCHAR2,
		v_admit_dttm					IN OUT VARCHAR2,
		v_discharge_dttm				IN OUT VARCHAR2,

		v_p_prior_patient_id			OUT VARCHAR2,
		v_p_patient_id_issuer			OUT VARCHAR2,
		v_p_last_name					OUT VARCHAR2,
		v_p_first_name					OUT VARCHAR2,
		v_p_middle_name					OUT VARCHAR2,
		v_p_prefix						OUT VARCHAR2,
		v_p_suffix						OUT VARCHAR2,
		v_p_marital_status				OUT VARCHAR2,
		v_p_confidentiality				OUT VARCHAR2,
		v_p_patient_death_dttm			OUT VARCHAR2,
		v_p_blood_type_rh				OUT VARCHAR2,
		v_p_citizenship					OUT VARCHAR2,
		v_p_occupation					OUT VARCHAR2,
		v_p_race_code					OUT VARCHAR2,
		v_p_language_code				OUT VARCHAR2,
		v_p_religion_code				OUT VARCHAR2,
		v_p_birth_place					OUT VARCHAR2,
		v_p_multiple_birth_status		OUT VARCHAR2,
		v_p_birth_order					OUT VARCHAR2,
		v_p_cell_phone_no				OUT VARCHAR2,
		v_p_pregnancy_code				OUT VARCHAR2,
		v_p_patient_status				OUT VARCHAR2,
		v_p_account_number				OUT VARCHAR2,
		v_p_contact_type				OUT VARCHAR2,
		v_p_business_phone_no			OUT VARCHAR2,
		v_p_city						OUT VARCHAR2,
		v_p_state						OUT VARCHAR2,
		v_p_country						OUT VARCHAR2,
		v_p_visit_number				OUT VARCHAR2,
		v_p_visit_status				OUT VARCHAR2,
		v_p_consult_doctor_id			OUT VARCHAR2,
		v_p_institution_code			OUT VARCHAR2,
		v_p_visit_comments				OUT VARCHAR2,
		v_p_admit_route					OUT VARCHAR2,
		v_p_last_menstrual_dttm			OUT VARCHAR2,
		v_p_code_abbreviation			OUT VARCHAR2,
		v_p_station_code				OUT VARCHAR2,
		v_p_consult_doctor_name			OUT VARCHAR2,
		v_p_broker_type					OUT VARCHAR2
	)
	IS

	BEGIN
		v_broker_aetitle				:= v_broker_aetitle;
		v_event_type					:= 'ADT^A04';
		v_patient_id					:= substr(v_patient_id, 1, 32);
		v_patient_name					:= substr(v_patient_name, 1, 64);
		v_english_name					:= substr(v_english_name, 1, 32);
		v_patient_ssn					:= substr(v_patient_ssn, 1, 32);
		v_patient_birth_dttm			:= substr(v_patient_birth_dttm, 1, 8);
		v_patient_sex					:= substr(v_patient_sex, 1, 3);
		v_patient_weight				:= substr(v_patient_weight, 1, 8);
		v_patient_size					:= substr(v_patient_size, 1, 8);
		v_ethnic_group					:= substr(v_ethnic_group, 1, 32);
		v_tel_no						:= substr(v_tel_no, 1, 32);
		v_fax_no						:= substr(v_fax_no, 1, 32);
		v_zipcode						:= substr(v_zipcode, 1, 16);
		v_address						:= substr(v_address, 1, 128);
		v_email							:= substr(v_email, 1, 64);
		v_blood_type					:= substr(v_blood_type, 1, 8);
		v_pregnancy_status				:= substr(v_pregnancy_status, 1, 3);
		v_current_location				:= substr(v_current_location, 1, 32);
		v_current_residency				:= substr(v_current_residency, 1, 32);
		v_current_department			:= substr(v_current_department, 1, 32);
		v_current_doctor_id				:= substr(v_current_doctor_id, 1, 32);
		v_current_doctor_name			:= substr(v_current_doctor_name, 1, 64);
		v_admit_dttm					:= substr(v_admit_dttm, 1, 14);
		v_discharge_dttm				:= substr(v_discharge_dttm, 1, 14);

		v_p_prior_patient_id			:= NULL;
		v_p_patient_id_issuer			:= NULL;
		v_p_last_name					:= NULL;
		v_p_first_name					:= NULL;
		v_p_middle_name					:= NULL;
		v_p_prefix						:= NULL;
		v_p_suffix						:= NULL;
		v_p_marital_status				:= NULL;
		v_p_confidentiality				:= NULL;
		v_p_patient_death_dttm			:= NULL;
		v_p_blood_type_rh				:= NULL;
		v_p_citizenship					:= NULL;
		v_p_occupation					:= NULL;
		v_p_race_code					:= NULL;
		v_p_language_code				:= NULL;
		v_p_religion_code				:= NULL;
		v_p_birth_place					:= NULL;
		v_p_multiple_birth_status		:= NULL;
		v_p_birth_order					:= NULL;
		v_p_cell_phone_no				:= NULL;
		v_p_pregnancy_code				:= NULL;
		v_p_patient_status				:= NULL;
		v_p_account_number				:= NULL;
		v_p_contact_type				:= NULL;
		v_p_business_phone_no			:= NULL;
		v_p_city						:= NULL;
		v_p_state						:= NULL;
		v_p_country						:= NULL;
		v_p_visit_number				:= NULL;
		v_p_visit_status				:= NULL;
		v_p_consult_doctor_id			:= NULL;
		v_p_institution_code			:= NULL;
		v_p_visit_comments				:= NULL;
		v_p_admit_route					:= NULL;
		v_p_last_menstrual_dttm			:= NULL;
		v_p_code_abbreviation			:= NULL;
		v_p_station_code				:= NULL;
		v_p_consult_doctor_name			:= NULL;
		v_p_broker_type					:= 'ODBC';
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE mwl_to_mwl
	(
		v_broker_aetitle				IN OUT VARCHAR2,
		v_order_control_id				IN OUT VARCHAR2,
		v_event_type					IN OUT VARCHAR2,
		v_character_set					IN OUT VARCHAR2,
		v_scheduled_aetitle				IN OUT VARCHAR2,
		v_scheduled_dttm				IN OUT VARCHAR2,
		v_scheduled_modality			IN OUT VARCHAR2,
		v_scheduled_station				IN OUT VARCHAR2,
		v_scheduled_location			IN OUT VARCHAR2,
		v_scheduled_proc_id				IN OUT VARCHAR2,	-- 10
		v_scheduled_proc_desc			IN OUT VARCHAR2,
		v_scheduled_action_codes		IN OUT VARCHAR2,
		v_scheduled_proc_status			IN OUT VARCHAR2,
		v_premedication					IN OUT VARCHAR2,
		v_contrast_agent				IN OUT VARCHAR2,
		v_requested_proc_id				IN OUT VARCHAR2,
		v_requested_proc_desc			IN OUT VARCHAR2,
		v_requested_proc_codes			IN OUT VARCHAR2,
		v_requested_proc_priority		IN OUT VARCHAR2,
		v_requested_proc_reason			IN OUT VARCHAR2,	-- 20
		v_requested_proc_comments		IN OUT VARCHAR2,
		v_study_instance_uid			IN OUT VARCHAR2,
		v_proc_placer_order_no			IN OUT VARCHAR2,
		v_proc_filler_order_no			IN OUT VARCHAR2,
		v_accession_no					IN OUT VARCHAR2,
		v_attend_doctor					IN OUT VARCHAR2,
		v_perform_doctor				IN OUT VARCHAR2,
		v_consult_doctor				IN OUT VARCHAR2,
		v_request_doctor				IN OUT VARCHAR2,
		v_refer_doctor					IN OUT VARCHAR2,	-- 30
		v_request_department			IN OUT VARCHAR2,
		v_imaging_request_reason		IN OUT VARCHAR2,
		v_imaging_request_comments		IN OUT VARCHAR2,
		v_imaging_request_dttm			IN OUT VARCHAR2,
		v_isr_placer_order_no			IN OUT VARCHAR2,
		v_isr_filler_order_no			IN OUT VARCHAR2,
		v_admission_id					IN OUT VARCHAR2,
		v_patient_transport				IN OUT VARCHAR2,
		v_patient_location				IN OUT VARCHAR2,
		v_patient_residency				IN OUT VARCHAR2,	-- 40
		v_patient_name					IN OUT VARCHAR2,
		v_patient_id					IN OUT VARCHAR2,
		v_other_patient_name			IN OUT VARCHAR2,
		v_other_patient_id				IN OUT VARCHAR2,
		v_patient_birth_dttm			IN OUT VARCHAR2,
		v_patient_sex					IN OUT VARCHAR2,
		v_patient_weight				IN OUT VARCHAR2,
		v_patient_size					IN OUT VARCHAR2,
		v_patient_state					IN OUT VARCHAR2,
		v_confidentiality				IN OUT VARCHAR2,	-- 50
		v_pregnancy_status				IN OUT VARCHAR2,
		v_medical_alerts				IN OUT VARCHAR2,
		v_contrast_allergies			IN OUT VARCHAR2,
		v_special_needs					IN OUT VARCHAR2,
		v_specialty						IN OUT VARCHAR2,
		v_diagnosis						IN OUT VARCHAR2,
		v_admit_dttm					IN OUT VARCHAR2,
		v_register_dttm					IN OUT VARCHAR2,
		v_study_ssn						IN OUT VARCHAR2,			
		v_insurance_code				IN OUT VARCHAR2,
		v_emergency						IN OUT VARCHAR2,
		v_special_doctor				IN OUT VARCHAR2,	--62

		v_m_patient_id_issuer			OUT VARCHAR2,
		v_m_last_name					OUT VARCHAR2,
		v_m_first_name					OUT VARCHAR2,
		v_m_middle_name					OUT VARCHAR2,
		v_m_prefix						OUT VARCHAR2,
		v_m_suffix						OUT VARCHAR2,
		v_m_race_code					OUT VARCHAR2,
		v_m_account_no					OUT VARCHAR2,
		v_m_address						OUT VARCHAR2,
		v_m_order_entry_user_id			OUT VARCHAR2,
		v_m_order_entry_location		OUT VARCHAR2,
		v_m_order_callback_phone_no		OUT VARCHAR2,
		v_m_req_proc_status				OUT VARCHAR2,
		v_m_req_proc_code_scheme		OUT VARCHAR2,
		v_m_req_proc_code_version		OUT VARCHAR2,
		v_m_req_proc_code_meaning		OUT VARCHAR2,
		v_m_req_proc_location			OUT VARCHAR2,
		v_m_patient_arrange				OUT VARCHAR2,
		v_m_source_aetitle				OUT VARCHAR2,
		v_m_broker_type					OUT VARCHAR2
	)
	IS
	BEGIN
		--v_order_control_id		:= v_event_type;
		IF v_scheduled_proc_status = '0' THEN	 		-- cancel order
			v_order_control_id := 'CA';
		ELSIF v_scheduled_proc_status = '100' THEN		-- new order (status: Ordered)
			v_order_control_id := 'NW';
		ELSIF v_scheduled_proc_status = '120' THEN		-- new order (status: Scheduled)
			v_order_control_id := 'NW';
		END IF;

		v_event_type					:= rtrim(v_event_type);
		v_character_set					:= substr(rtrim(v_character_set), 1, 32);
		v_scheduled_aetitle				:= substr(NVL(rtrim(v_scheduled_aetitle), 'NULL'), 1, 16);
		v_scheduled_dttm				:= substr(NVL(rtrim(v_scheduled_dttm), rtrim(v_imaging_request_dttm)), 1, 14);
		v_scheduled_modality			:= substr(rtrim(v_scheduled_modality), 1, 8);
		v_scheduled_station				:= substr(rtrim(v_scheduled_station), 1, 32);
		v_scheduled_location			:= substr(rtrim(v_scheduled_location), 1, 32);
		v_scheduled_proc_id				:= substr(rtrim(v_scheduled_proc_id), 1, 32);
		v_scheduled_proc_desc			:= substr(rtrim(v_scheduled_proc_desc), 1, 64);
		v_scheduled_action_codes		:= substr(rtrim(v_scheduled_action_codes), 1, 256);
		IF v_scheduled_action_codes IS NULL THEN
			v_scheduled_action_codes	:= NVL(rtrim(v_scheduled_proc_id), 'NULL');
		ELSE
			v_scheduled_action_codes	:= SUBSTR(sp_util.parse_string(rtrim(v_scheduled_action_codes), ':',1), 1, 32);
		END IF;
		v_scheduled_proc_status			:= substr(rtrim(v_scheduled_proc_status), 1, 32);
		v_premedication					:= substr(rtrim(v_premedication), 1, 32);
		v_contrast_agent				:= substr(rtrim(v_contrast_agent), 1, 32);
		v_requested_proc_id				:= substr(rtrim(v_requested_proc_id), 1, 32);
		v_requested_proc_desc			:= substr(rtrim(v_requested_proc_desc), 1, 64);
		v_requested_proc_codes			:= substr(rtrim(v_requested_proc_codes), 1, 256);
		IF v_requested_proc_codes IS NULL THEN
			v_requested_proc_codes  	:= NVL(rtrim(v_requested_proc_id), 'NULL');
		ELSE
			v_requested_proc_codes 		:= SUBSTR(sp_util.parse_string(rtrim(v_requested_proc_codes), ':',1), 1, 32);
		END IF;
		v_requested_proc_priority		:= substr(rtrim(v_requested_proc_priority), 1, 32);
		v_requested_proc_reason			:= substr(rtrim(v_requested_proc_reason), 1, 256);
		v_requested_proc_comments		:= substr(rtrim(v_requested_proc_comments), 1, 4000);
		v_study_instance_uid			:= substr(rtrim(v_study_instance_uid), 1, 64);
		v_proc_placer_order_no			:= substr(rtrim(v_proc_placer_order_no), 1, 32);
		v_proc_filler_order_no			:= substr(rtrim(v_proc_filler_order_no), 1, 32);
		v_accession_no		   			:= substr(rtrim(v_accession_no), 1, 32);
		v_attend_doctor					:= substr(rtrim(v_attend_doctor), 1, 32);
		
		v_perform_doctor	   			:= substr(rtrim(v_perform_doctor), 1, 32);
		
		v_consult_doctor	   			:= substr(rtrim(v_consult_doctor), 1, 32);
		v_request_doctor	   			:= NVL(NVL(substr(rtrim(v_request_doctor), 1, 32), rtrim(v_attend_doctor)), 'NULL');
		v_refer_doctor					:= substr(rtrim(v_refer_doctor), 1, 32);
		v_request_department			:= substr(rtrim(v_request_department), 1, 32);
		v_imaging_request_reason		:= substr(rtrim(v_imaging_request_reason), 1, 256);
		v_imaging_request_comments		:= substr(rtrim(v_imaging_request_comments), 1, 4000);
		v_imaging_request_dttm			:= substr(rtrim(v_imaging_request_dttm), 1, 14);
		v_isr_placer_order_no			:= substr(rtrim(v_isr_placer_order_no), 1, 32);
		v_isr_filler_order_no			:= substr(rtrim(v_isr_filler_order_no), 1, 32);
		v_admission_id		   			:= substr(rtrim(v_admission_id), 1, 32);
		v_patient_transport				:= substr(rtrim(v_patient_transport), 1, 32);
		v_patient_location				:= substr(rtrim(v_patient_location), 1, 32);
		v_patient_residency				:= substr(rtrim(v_patient_residency), 1, 32);
		v_patient_name					:= substr(rtrim(v_patient_name), 1, 64);
		v_patient_id					:= substr(rtrim(v_patient_id), 1, 32);
		v_other_patient_name			:= substr(rtrim(v_other_patient_name), 1, 64);
		v_other_patient_id				:= substr(rtrim(v_other_patient_id), 1, 32);
		v_patient_birth_dttm			:= substr(rtrim(v_patient_birth_dttm), 1, 8);
		v_patient_sex					:= substr(rtrim(v_patient_sex), 1, 3);
		v_patient_weight				:= substr(rtrim(v_patient_weight), 1, 16);
		v_patient_size					:= substr(rtrim(v_patient_size), 1, 16);
		
		v_patient_state					:= substr(rtrim(v_patient_state), 1, 32);
		
		v_confidentiality				:= 'Y'; --NVL(substr(v_confidentiality, 1, 256), 'Y');
		v_pregnancy_status				:= substr(rtrim(v_pregnancy_status), 1, 256);
		v_medical_alerts				:= substr(rtrim(v_medical_alerts), 1, 256);
		v_contrast_allergies			:= substr(rtrim(v_contrast_allergies), 1, 256);
		v_special_needs					:= substr(rtrim(v_special_needs), 1, 32);
		v_specialty						:= substr(rtrim(v_specialty), 1, 32);
		v_diagnosis						:= substr(rtrim(v_diagnosis), 1, 2048);
		v_admit_dttm					:= substr(rtrim(v_admit_dttm), 1, 14);
		v_register_dttm					:= substr(rtrim(v_register_dttm), 1, 14);
		v_study_ssn						:= substr(rtrim(v_study_ssn), 1, 64);
		v_insurance_code				:= substr(rtrim(v_insurance_code), 1, 64);
		v_emergency						:= substr(rtrim(v_emergency), 1, 8);
		v_special_doctor				:= substr(rtrim(v_special_doctor), 1, 32);

		v_m_patient_id_issuer			:= NULL;
		v_m_last_name					:= NULL;
		v_m_first_name					:= NULL;
		v_m_middle_name					:= NULL;
		v_m_prefix						:= NULL;
		v_m_suffix						:= NULL;
		v_m_race_code					:= NULL;
		v_m_account_no					:= NULL;
		v_m_address						:= NULL;
		v_m_order_entry_user_id			:= NULL;
		v_m_order_entry_location		:= NULL;
		v_m_order_callback_phone_no		:= NULL;
		v_m_req_proc_status				:= NULL;
		v_m_req_proc_code_scheme		:= NULL;
		v_m_req_proc_code_version		:= NULL;
		v_m_req_proc_code_meaning		:= NULL;
		v_m_req_proc_location			:= NULL;
		v_m_patient_arrange				:= NULL;
		v_m_source_aetitle				:= v_scheduled_aetitle;
		v_m_broker_type					:= 'ODBC';
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE report_to_report
	(
		v_broker_aetitle				IN OUT VARCHAR2,
		v_flow_type						IN OUT NUMBER,
		v_patient_id					IN OUT VARCHAR2,
		v_exam_id						IN OUT VARCHAR2,
		v_study_instance_uid			IN OUT VARCHAR2,
		v_report_stat					IN OUT VARCHAR2,
		v_creator_id					IN OUT VARCHAR2,
		v_creator_name					IN OUT VARCHAR2,
		v_create_dttm					IN OUT VARCHAR2,
		v_dictator_id					IN OUT VARCHAR2,	-- 10
		v_dictator_name					IN OUT VARCHAR2,
		v_dictate_dttm					IN OUT VARCHAR2,
		v_transcriber_id				IN OUT VARCHAR2,
		v_transcriber_name				IN OUT VARCHAR2,
		v_transcribe_dttm				IN OUT VARCHAR2,
		v_approver_id					IN OUT VARCHAR2,
		v_approver_name					IN OUT VARCHAR2,
		v_approve_dttm					IN OUT VARCHAR2,
		v_reviser_id					IN OUT VARCHAR2,
		v_reviser_name					IN OUT VARCHAR2,	-- 20
		v_revise_dttm					IN OUT VARCHAR2,
		v_report_type					IN OUT VARCHAR2,
		v_report_text					IN OUT LONG,
		v_conclusion					IN OUT LONG,
		v_study_dttm					IN OUT VARCHAR2,
		v_scheduled_location			IN OUT VARCHAR2,
		v_perform_department			IN OUT VARCHAR2,
		v_perform_modality				IN OUT VARCHAR2,
		v_request_dttm					IN OUT VARCHAR2,
		v_request_name					IN OUT VARCHAR2,    -- 30
		v_request_code					IN OUT VARCHAR2,
		v_request_doctor				IN OUT VARCHAR2,
		v_perform_doctor				IN OUT VARCHAR2,
		v_refer_doctor					IN OUT VARCHAR2,
		v_scheduled_dttm				IN OUT VARCHAR2,
		v_patient_name					IN OUT VARCHAR2,
		v_patient_sex					IN OUT VARCHAR2,
		v_patient_birth_dttm			IN OUT VARCHAR2,
		v_admission_id					IN OUT VARCHAR2,
		v_study_comments				IN OUT VARCHAR2,    -- 40
		v_study_reason					IN OUT VARCHAR2,
		v_attend_doctor					IN OUT VARCHAR2,
		v_patient_location				IN OUT VARCHAR2,
		v_scheduled_station				IN OUT VARCHAR2,		
		v_r_strFxCode					IN OUT VARCHAR2,
		v_r_strFxDesc					IN OUT VARCHAR2,
		v_r_strDxCode					IN OUT VARCHAR2,
		v_r_strDxDesc					IN OUT VARCHAR2,      		
		v_digital_sign_flag   			IN OUT VARCHAR2,   --report digital sign
		v_digital_sign_data             IN OUT VARCHAR2,
		v_digital_sign_dttm             IN OUT VARCHAR2,
		v_certificate_dn                IN OUT VARCHAR2,
		v_digital_sign_key				IN OUT VARCHAR2, 

		v_r_event_type					OUT	VARCHAR2,
		v_r_report_control_id			OUT	VARCHAR2,
		v_r_broker_type					OUT	VARCHAR2
	)
	IS
		v_report_text_lob				report.report_text_lob%TYPE;
		v_Cnt							NUMBER;
		v_Pos							NUMBER;   
		v_Num                           NUMBER:=1;  
		i                          		NUMBER:=1; 
		v_Temp			                VARCHAR2(3000);

	BEGIN
		IF v_flow_type = 0 THEN			-- 0 : report inbound

			v_patient_id			:= v_patient_id;
			v_exam_id		   		:= v_exam_id;
			v_report_stat			:= NVL(v_report_stat, 'F');
			v_creator_id			:= v_creator_id;
			v_creator_name			:= v_creator_name;
			v_create_dttm			:= v_create_dttm;
			v_dictator_id			:= v_dictator_id;
			v_dictator_name			:= v_dictator_name;
			v_dictate_dttm			:= v_dictate_dttm;
			v_transcriber_id		:= v_transcriber_id;
			v_transcriber_name		:= v_transcriber_name;
			v_transcribe_dttm		:= v_transcribe_dttm;
			v_approver_id			:= v_approver_id;
			v_approver_name			:= v_approver_name;
			v_approve_dttm			:= v_approve_dttm;
			v_reviser_id			:= v_reviser_id;
			v_reviser_name			:= v_reviser_name;
			v_revise_dttm			:= v_revise_dttm;
			v_report_type			:= v_report_type;
			v_report_text			:= v_report_text;
			v_conclusion			:= v_conclusion;

			v_r_event_type				:= NULL;
			v_r_report_control_id		:= NULL;
			v_r_broker_type				:= 'ODBC';

		ELSE					-- 1 : report outbound
			/*IF v_report_type = 'text' THEN
				-- multi row processing
				v_Cnt := 0;
				FOR r IN (SELECT r.report_text_lob
						FROM study s, report r
						WHERE s.study_instance_uid = v_study_instance_uid
							AND s.study_key = r.study_key
						order by r.report_key asc
						)
				LOOP  
					 v_Cnt :=  v_Cnt + 1;        
					 IF v_Cnt >1 THEN
					  	v_report_text_lob := v_report_text_lob || chr(13) || chr(10) || '[Addendum Report]' || chr(13) || chr(10) || r.report_text_lob || ' ';	
					 ELSE
					 	v_report_text_lob := v_report_text_lob || r.report_text_lob;
					 END IF;
				END LOOP;
				--#92966 by mryang
				IF length(v_report_text_lob)>4000 THEN	
					v_Pos := trunc(length(v_report_text_lob)/2000)+1;    
					--dbms_output.put_line('v_Pos:' || v_Pos);  
					      
		            FOR v_Num IN 1..v_Pos LOOP
		            	dbms_output.put_line('i := ' || i); 
						v_Temp := DBMS_LOB.SUBSTR(v_report_text_lob, 2000, i);
			    	   	v_report_text := v_report_text || v_Temp; 
			    	   	i := v_Num * 2000 +1;    
			    	END LOOP;	
			    	
			    	v_Pos := instr(v_report_text, '====== [Conclusion] ======',1,1);
			    	--dbms_output.put_line('v_Pos:' || v_Pos);
			    	IF v_Pos > 0 THEN			 
		            	v_report_text :=  substr(v_report_text,0,instr(v_report_text, '====== [Conclusion] ======',1,1)-1); 
		            END IF;
		       	ELSE  
				 	v_report_text :=  DBMS_LOB.substr(v_report_text_lob,DBMS_LOB.instr(v_report_text_lob, '====== [Conclusion] ======',1,1)-1,1); 
	           END IF;
	
				v_conclusion:=substr(v_report_text, 29 + length(v_report_text), length(v_report_text));
				
			END IF;*/

			v_patient_id			:= v_patient_id;
			v_exam_id				:= v_exam_id;
			v_study_instance_uid	:= v_study_instance_uid;
			v_report_stat			:= NVL(v_report_stat, 'F');
			v_creator_id			:= v_creator_id;
			v_creator_name			:= v_creator_name;
			v_create_dttm			:= v_create_dttm;
			v_dictator_id			:= v_dictator_id;
			v_dictator_name			:= v_dictator_name;
			v_dictate_dttm			:= v_dictate_dttm;
			v_transcriber_id		:= v_transcriber_id;
			v_transcriber_name		:= v_transcriber_name;
			v_transcribe_dttm		:= v_transcribe_dttm;
			v_approver_id			:= v_approver_id;
			v_approver_name			:= v_approver_name;
			v_approve_dttm			:= v_approve_dttm;
			v_reviser_id			:= v_reviser_id;
			v_reviser_name			:= v_reviser_name;
			v_revise_dttm			:= v_revise_dttm;
			v_report_type			:= v_report_type;
			v_report_text			:= v_report_text;
			v_conclusion			:= v_conclusion;
			v_study_dttm			:= v_study_dttm;
			v_scheduled_location	:= v_scheduled_location;
			v_perform_department	:= v_perform_department;
			v_perform_modality		:= v_perform_modality;
			v_request_dttm			:= v_request_dttm;
			v_request_name			:= v_request_name;
			v_request_code			:= v_request_code;
			v_request_doctor		:= v_request_doctor;
			v_perform_doctor		:= v_perform_doctor;
			v_refer_doctor			:= v_refer_doctor;
			v_scheduled_dttm		:= v_scheduled_dttm;
			v_patient_name			:= v_patient_name;
			v_patient_sex			:= v_patient_sex;
			v_patient_birth_dttm	:= v_patient_birth_dttm;
			v_admission_id			:= v_admission_id;
			v_study_comments		:= v_study_comments;
			v_study_reason			:= v_study_reason;
			v_attend_doctor			:= v_attend_doctor;
			v_patient_location		:= v_patient_location;
			v_scheduled_station		:= v_scheduled_station;  
			v_digital_sign_flag   	:= v_digital_sign_flag;
			v_digital_sign_data     := v_digital_sign_data;
			v_digital_sign_dttm     := v_digital_sign_dttm;
			v_certificate_dn        := v_certificate_dn;
			v_digital_sign_key		:= v_digital_sign_key;

		END IF;
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE report_to_oru
	(
		v_r_broker_aetitle				IN VARCHAR2,
		v_r_patient_id					IN VARCHAR2,
		v_r_exam_id						IN VARCHAR2,
		v_r_study_instance_uid			IN VARCHAR2,
		v_r_report_stat					IN VARCHAR2,
		v_r_creator_id					IN VARCHAR2,
		v_r_creator_name				IN VARCHAR2,
		v_r_create_dttm					IN VARCHAR2,
		v_r_dictator_id					IN VARCHAR2,
		v_r_dictator_name				IN VARCHAR2,
		v_r_dictate_dttm				IN VARCHAR2,
		v_r_transcriber_id				IN VARCHAR2,
		v_r_transcriber_name			IN VARCHAR2,
		v_r_transcribe_dttm				IN VARCHAR2,
		v_r_approver_id					IN VARCHAR2,
		v_r_approver_name				IN VARCHAR2,
		v_r_approve_dttm				IN VARCHAR2,
		v_r_reviser_id					IN VARCHAR2,
		v_r_reviser_name				IN VARCHAR2,
		v_r_revise_dttm					IN VARCHAR2,
		v_r_report_type					IN VARCHAR2,
		v_r_report_text					IN LONG,
		v_r_conclusion					IN LONG,
		v_r_study_dttm					IN VARCHAR2,
		v_r_scheduled_location			IN VARCHAR2,
		v_r_perform_department			IN VARCHAR2,
		v_r_perform_modality			IN VARCHAR2,
		v_r_request_dttm				IN VARCHAR2,
		v_r_request_name				IN VARCHAR2,
		v_r_request_code				IN VARCHAR2,
		v_r_request_doctor				IN VARCHAR2,
		v_r_perform_doctor				IN VARCHAR2,
		v_r_refer_doctor				IN VARCHAR2,
		v_r_scheduled_dttm				IN VARCHAR2,
		v_r_patient_name				IN VARCHAR2,
		v_r_patient_sex					IN VARCHAR2,
		v_r_patient_birth_dttm			IN VARCHAR2,
		v_r_admission_id				IN VARCHAR2,
		v_r_study_comments				IN VARCHAR2,
		v_r_study_reason				IN VARCHAR2,
		v_r_attend_doctor				IN VARCHAR2,
		v_r_patient_location			IN VARCHAR2,
		v_r_ScheduledStation			IN VARCHAR2,
		v_r_strFxCode					IN VARCHAR2,
		v_r_strFxDesc					IN VARCHAR2,
		v_r_strDxCode					IN VARCHAR2,
		v_r_strDxDesc					IN VARCHAR2,

		v_oru_message_control_id		OUT VARCHAR2,
		v_oru_event_type				OUT VARCHAR2,
		v_oru_patient_account_no		OUT VARCHAR2,
		v_oru_patient_id		 		OUT VARCHAR2,
		v_oru_patient_name				OUT VARCHAR2,
		v_oru_patient_ename				OUT VARCHAR2,
		v_oru_patient_ssn				OUT VARCHAR2,
		v_oru_patient_birth_dttm		OUT VARCHAR2,
		v_oru_patient_sex				OUT VARCHAR2,
		v_oru_refering_doctor_id		OUT VARCHAR2,
		v_oru_refering_doctor_name		OUT VARCHAR2,
		v_oru_attending_doctor_id		OUT VARCHAR2,
		v_oru_attending_doctor_name		OUT VARCHAR2,
		v_oru_prior_patient_location	OUT VARCHAR2,
		v_oru_consulting_doctor_id		OUT VARCHAR2,
		v_oru_consulting_doctor_name	OUT VARCHAR2,
		v_oru_patient_class				OUT VARCHAR2,
		v_oru_scheduled_date_time		OUT VARCHAR2,
		v_oru_filler_order_no			OUT VARCHAR2,
		v_oru_quantity_timing			OUT VARCHAR2,
		v_oru_universal_service_id		OUT VARCHAR2,
		v_oru_requested_date_time		OUT VARCHAR2,
		v_oru_specimen_source			OUT VARCHAR2,
		v_oru_diagnostic_serv_sect_id	OUT VARCHAR2,
		v_oru_placer_field1				OUT VARCHAR2,
		v_oru_placer_field2				OUT VARCHAR2,
		v_oru_filler_field1	 			OUT VARCHAR2,
		v_oru_filler_field2				OUT VARCHAR2,
		v_oru_reason_for_study			OUT VARCHAR2,
		v_oru_observation_identifier 	OUT VARCHAR2,
		v_oru_observation_value			OUT VARCHAR2,
		v_oru_observation_status		OUT VARCHAR2,
		v_oru_observation_date_time		OUT VARCHAR2,
		v_oru_responsible_observer		OUT VARCHAR2,
		v_oru_field1		 			OUT VARCHAR2,
		v_oru_field2					OUT VARCHAR2,
		v_oru_field3					OUT VARCHAR2,
		v_oru_field4					OUT VARCHAR2,
		v_oru_field5					OUT VARCHAR2,
		v_oru_field6					OUT VARCHAR2,
		v_oru_field7					OUT VARCHAR2,
		v_oru_field8					OUT VARCHAR2,
		v_oru_field9					OUT VARCHAR2,
		v_oru_field10					OUT VARCHAR2
	)
	IS
	BEGIN
		v_oru_message_control_id		:= NULL;
		v_oru_event_type				:= NULL;
		v_oru_patient_account_no		:= NULL;
		v_oru_patient_id				:= v_r_patient_id;
		v_oru_patient_name				:= v_r_patient_name;
		v_oru_patient_ename				:= NULL;
		v_oru_patient_ssn				:= NULL;
		v_oru_patient_birth_dttm		:= NULL;
		v_oru_patient_sex				:= v_r_patient_sex;
		v_oru_refering_doctor_id		:= NULL;
		v_oru_refering_doctor_name		:= NULL;
		v_oru_attending_doctor_id		:= NULL;
		v_oru_attending_doctor_name		:= NULL;
		v_oru_prior_patient_location	:= NULL;
		v_oru_consulting_doctor_id		:= NULL;
		v_oru_consulting_doctor_name	:= NULL;
		v_oru_patient_class				:= v_r_patient_location;
		v_oru_scheduled_date_time		:= NULL;
		v_oru_filler_order_no			:= NULL;
		v_oru_quantity_timing			:= NULL;
		v_oru_universal_service_id		:= v_r_request_name;
		v_oru_requested_date_time		:= v_r_study_dttm;
		v_oru_specimen_source			:= NULL;
		v_oru_diagnostic_serv_sect_id	:= v_r_perform_modality;
		v_oru_placer_field1				:= v_r_exam_id;
		v_oru_placer_field2				:= v_r_exam_id;
		v_oru_filler_field1				:= NULL;
		v_oru_filler_field2				:= NULL;
		v_oru_reason_for_study			:= NULL;
		v_oru_observation_identifier	:= v_r_exam_id;
		v_oru_observation_value			:= v_r_report_text;
		v_oru_observation_status		:= v_r_report_stat;
		v_oru_observation_date_time		:= v_r_approve_dttm;
		v_oru_responsible_observer		:= v_r_approver_id || '^' || v_r_approver_name;
		v_oru_field1					:= v_r_conclusion;
		v_oru_field2					:= NULL;
		v_oru_field3					:= NULL;
		v_oru_field4					:= NULL;
		v_oru_field5					:= NULL;
		v_oru_field6					:= NULL;
		v_oru_field7					:= NULL;
		v_oru_field8					:= NULL;
		v_oru_field9					:= NULL;
		v_oru_field10					:= NULL;
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE user_to_user
	(
		v_broker_aetitle				IN OUT	VARCHAR2,
		v_user_id						IN OUT	VARCHAR2,
		v_user_name						IN OUT	VARCHAR2,
		v_password						IN OUT	VARCHAR2,
		v_user_level					IN OUT	VARCHAR2,
		v_user_status					IN OUT	VARCHAR2,
		v_comments						IN OUT	VARCHAR2
	)
	IS

	BEGIN
		v_user_id			:= substr(v_user_id, 1, 16);
		v_user_name			:= substr(v_user_name, 1, 64);
		v_password			:= substr(v_password, 1, 16);
		v_user_level		:= substr(v_user_level, 1, 16);
		v_user_status		:= substr(v_user_status, 1, 16);
		v_comments			:= v_comments;
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE sr_to_report
	(
		v_sr_broker_aetitle				IN	VARCHAR2,
		v_sr_is_complete				IN	NUMBER,
		v_sr_is_verified				IN	NUMBER,
		v_sr_patient_id		 			IN	VARCHAR2,
		v_sr_patient_name	 			IN	VARCHAR2,
		v_sr_patient_sex				IN	VARCHAR2,
		v_sr_patient_birth_date			IN	VARCHAR2,
		v_sr_patient_birth_time	 		IN	VARCHAR2,
		v_sr_study_instance_uid	 		IN	VARCHAR2,
		v_sr_study_id					IN	VARCHAR2,
		v_sr_access_no					IN	VARCHAR2,
		v_sr_study_date					IN	VARCHAR2,
		v_sr_study_time					IN	VARCHAR2,
		v_sr_study_desc					IN	VARCHAR2,
		v_sr_institution				IN	VARCHAR2,
		v_sr_department					IN	VARCHAR2,
		v_sr_consumer_id				IN	VARCHAR2,
		v_sr_consumer_name				IN	VARCHAR2,
		v_sr_creator_id					IN	VARCHAR2,
		v_sr_creator_name				IN	VARCHAR2,
		v_sr_approver_id				IN	VARCHAR2,
		v_sr_approver_name				IN	VARCHAR2,
		v_sr_approve_dttm				IN	VARCHAR2,
		v_sr_report_text				IN	LONG,
		v_sr_report_buffer	 			IN	LONG,
		v_sr_conclusion		 			IN	LONG,

		v_patient_id					OUT	VARCHAR2,
		v_exam_id						OUT	VARCHAR2,
		v_report_stat					OUT	VARCHAR2,
		v_creator_id					OUT	VARCHAR2,
		v_creator_name					OUT	VARCHAR2,
		v_create_dttm					OUT	VARCHAR2,
		v_dictator_id					OUT	VARCHAR2,
		v_dictator_name					OUT	VARCHAR2,
		v_dictate_dttm					OUT	VARCHAR2,
		v_transcriber_id				OUT	VARCHAR2,
		v_transcriber_name				OUT	VARCHAR2,
		v_transcribe_dttm				OUT	VARCHAR2,
		v_approver_id					OUT	VARCHAR2,
		v_approver_name					OUT	VARCHAR2,
		v_approve_dttm					OUT	VARCHAR2,
		v_reviser_id					OUT	VARCHAR2,
		v_reviser_name					OUT	VARCHAR2,
		v_revise_dttm					OUT	VARCHAR2,
		v_report_type					OUT	VARCHAR2,
		v_report_text					OUT	LONG,
		v_conclusion					OUT	LONG,
		v_r_event_type					OUT	VARCHAR2,
		v_r_report_control_id			OUT	VARCHAR2,
		v_r_broker_type					OUT	VARCHAR2
	)
	IS
	BEGIN
		v_patient_id		:= v_sr_patient_id;
		v_exam_id			:= v_sr_access_no;

		IF v_sr_is_complete = 1 AND v_sr_is_verified = 1 THEN
			v_report_stat := '240';
		ELSE
			v_report_stat := '230';
		END IF;

		v_creator_id		:= v_sr_creator_id;
		v_creator_name		:= v_sr_creator_name;
		v_create_dttm		:= v_sr_approve_dttm;
		v_dictator_id		:= NULL;
		v_dictator_name		:= NULL;
		v_dictate_dttm		:= NULL;
		v_transcriber_id	:= NULL;
		v_transcriber_name	:= NULL;
		v_transcribe_dttm	:= NULL;
		v_approver_id		:= v_sr_approver_id;
		v_approver_name		:= v_sr_approver_name;
		v_approve_dttm		:= v_sr_approve_dttm;
		v_reviser_id		:= v_sr_approver_id;
		v_reviser_name		:= v_sr_approver_name;
		v_revise_dttm		:= v_sr_approve_dttm;
		v_report_type		:= NULL;
		v_report_text		:= v_sr_report_text || v_sr_report_buffer;
		v_conclusion		:= v_sr_conclusion;

		v_r_event_type				:= NULL;
		v_r_report_control_id		:= NULL;
		v_r_broker_type				:= 'ODBC';

	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE text_to_mwl
	(
		v_broker_aetitle				IN VARCHAR2,
		v_value01						IN VARCHAR2, 
		v_value02						IN VARCHAR2, 
		v_value03						IN VARCHAR2, 
		v_value04						IN VARCHAR2, 
		v_value05						IN VARCHAR2, 
		v_value06						IN VARCHAR2, 
		v_value07						IN VARCHAR2, 
		v_value08						IN VARCHAR2, 
		v_value09						IN VARCHAR2, 
		v_value10						IN VARCHAR2, 
		v_value11						IN VARCHAR2, 
		v_value12						IN VARCHAR2, 
		v_value13						IN VARCHAR2, 
		v_value14						IN VARCHAR2, 
		v_value15						IN VARCHAR2, 
		v_value16						IN VARCHAR2, 
		v_value17						IN VARCHAR2, 
		v_value18						IN VARCHAR2, 
		v_value19						IN VARCHAR2, 
		v_value20						IN VARCHAR2, 
		v_value21						IN VARCHAR2, 
		v_value22						IN VARCHAR2, 
		v_value23						IN VARCHAR2, 
		v_value24						IN VARCHAR2, 
		v_value25						IN VARCHAR2, 
		v_value26						IN VARCHAR2, 
		v_value27						IN VARCHAR2, 
		v_value28						IN VARCHAR2, 
		v_value29						IN VARCHAR2, 
		v_value30						IN VARCHAR2, 
		v_value31						IN VARCHAR2, 
		v_value32						IN VARCHAR2, 
		v_value33						IN VARCHAR2, 
		v_value34						IN VARCHAR2, 
		v_value35						IN VARCHAR2, 
		v_value36						IN VARCHAR2, 
		v_value37						IN VARCHAR2, 
		v_value38						IN VARCHAR2, 
		v_value39						IN VARCHAR2, 
		v_value40						IN VARCHAR2, 

		v_order_control_id				OUT VARCHAR2,
		v_event_type					OUT VARCHAR2,
		v_character_set					OUT VARCHAR2,
		v_scheduled_aetitle				OUT VARCHAR2,
		v_scheduled_dttm				OUT VARCHAR2,
		v_scheduled_modality			OUT VARCHAR2,
		v_scheduled_station				OUT VARCHAR2,
		v_scheduled_location			OUT VARCHAR2,
		v_scheduled_proc_id				OUT VARCHAR2,
		v_scheduled_proc_desc			OUT VARCHAR2,
		v_scheduled_action_codes		OUT VARCHAR2,
		v_scheduled_proc_status			OUT VARCHAR2,
		v_premedication					OUT VARCHAR2,
		v_contrast_agent				OUT VARCHAR2,
		v_requested_proc_id				OUT VARCHAR2,
		v_requested_proc_desc			OUT VARCHAR2,
		v_requested_proc_codes			OUT VARCHAR2,
		v_requested_proc_priority		OUT VARCHAR2,
		v_requested_proc_reason			OUT VARCHAR2,
		v_requested_proc_comments		OUT VARCHAR2,
		v_study_instance_uid			OUT VARCHAR2,
		v_proc_placer_order_no			OUT VARCHAR2,
		v_proc_filler_order_no			OUT VARCHAR2,
		v_accession_no					OUT VARCHAR2,
		v_attend_doctor					OUT VARCHAR2,
		v_perform_doctor				OUT VARCHAR2,
		v_consult_doctor				OUT VARCHAR2,
		v_request_doctor				OUT VARCHAR2,
		v_refer_doctor					OUT VARCHAR2,
		v_request_department			OUT VARCHAR2,
		v_imaging_request_reason		OUT VARCHAR2,
		v_imaging_request_comments		OUT VARCHAR2,
		v_imaging_request_dttm			OUT VARCHAR2,
		v_isr_placer_order_no			OUT VARCHAR2,
		v_isr_filler_order_no			OUT VARCHAR2,
		v_admission_id					OUT VARCHAR2,
		v_patient_transport				OUT VARCHAR2,
		v_patient_location				OUT VARCHAR2,
		v_patient_residency				OUT VARCHAR2,
		v_patient_name					OUT VARCHAR2,
		v_patient_id					OUT VARCHAR2,
		v_other_patient_name			OUT VARCHAR2,
		v_other_patient_id				OUT VARCHAR2,
		v_patient_birth_dttm			OUT VARCHAR2,
		v_patient_sex					OUT VARCHAR2,
		v_patient_weight				OUT VARCHAR2,
		v_patient_size					OUT VARCHAR2,
		v_patient_state					OUT VARCHAR2,
		v_confidentiality				OUT VARCHAR2,
		v_pregnancy_status				OUT VARCHAR2,
		v_medical_alerts				OUT VARCHAR2,
		v_contrast_allergies			OUT VARCHAR2,
		v_special_needs					OUT VARCHAR2,
		v_specialty						OUT VARCHAR2,
		v_diagnosis						OUT VARCHAR2,
		v_admit_dttm					OUT VARCHAR2,
		v_register_dttm					OUT VARCHAR2,
		v_m_patient_id_issuer			OUT VARCHAR2,
		v_m_last_name					OUT VARCHAR2,
		v_m_first_name					OUT VARCHAR2,
		v_m_middle_name					OUT VARCHAR2,
		v_m_prefix						OUT VARCHAR2,
		v_m_suffix						OUT VARCHAR2,
		v_m_race_code					OUT VARCHAR2,
		v_m_account_no					OUT VARCHAR2,
		v_m_address						OUT VARCHAR2,
		v_m_order_entry_user_id			OUT VARCHAR2,
		v_m_order_entry_location		OUT VARCHAR2,
		v_m_order_callback_phone_no		OUT VARCHAR2,
		v_m_req_proc_status				OUT VARCHAR2,
		v_m_req_proc_code_scheme		OUT VARCHAR2,
		v_m_req_proc_code_version		OUT VARCHAR2,
		v_m_req_proc_code_meaning		OUT VARCHAR2,
		v_m_req_proc_location			OUT VARCHAR2,
		v_m_patient_arrange				OUT VARCHAR2,
		v_m_source_aetitle				OUT VARCHAR2,
		v_m_broker_aetitle				OUT VARCHAR2,
		v_m_broker_type					OUT VARCHAR2,
		v_m_study_ssn					OUT VARCHAR2
	)
	IS
	BEGIN
		-- This sample is designed for interfacing with UBCare company product.
		-- 이 샘플은 UBCare 의사랑 프로그램과의 연동에 사용되는 샘플입니다. 
		
		v_order_control_id			:= 'NW';
		v_event_type				:= 'ORM^';
		v_scheduled_aetitle			:= 'AE';
		v_scheduled_dttm			:= v_value21;
		v_scheduled_modality		:= v_value11;
		v_scheduled_proc_id			:= v_value13;
		v_requested_proc_id			:= v_value13;
		v_scheduled_proc_desc		:= v_value14;
		v_requested_proc_desc		:= v_value14;
		v_scheduled_proc_status		:= '120';
		v_accession_no				:= v_value05;
		v_request_doctor			:= v_value16;
		v_perform_doctor			:= v_value18;
		v_patient_id				:= v_value04;
		v_patient_name				:= v_value06;
		v_patient_birth_dttm		:= v_value08;
		v_patient_sex				:= substr(v_value09, 1, 1);
		v_register_dttm				:= v_value21;

		v_study_instance_uid		:= '1.2.410.200010.' || v_accession_no || '.' || v_scheduled_dttm;
		
        -- 01 내과         02 신경과       03 정신과     04 일반외과   05 정형외과
        -- 06 신경외과     07 흉부외과     08 성형외과   09 마취과     10 산부인과
        -- 11 소아과       12 안과         13 이비인후과 14 피부과     15 비뇨기과
        -- 16 진단방사선과 17 치료방사선과 18 해부병리과 19 임상병리과 20 결핵과
        -- 21 재활의학과   22 핵의학과     23 가정의학과 24 응급의학과 25 산업의학과

		IF    v_value19 = '01' THEN v_request_department := '내과';
		ELSIF v_value19 = '02' THEN v_request_department := '신경과';
		ELSIF v_value19 = '03' THEN v_request_department := '정신과';
		ELSIF v_value19 = '04' THEN v_request_department := '일반외과';
		ELSIF v_value19 = '05' THEN v_request_department := '정형외과';
		ELSIF v_value19 = '06' THEN v_request_department := '신경외과';
		ELSIF v_value19 = '07' THEN v_request_department := '흉부외과';
		ELSIF v_value19 = '08' THEN v_request_department := '성형외과';
		ELSIF v_value19 = '09' THEN v_request_department := '마취과';
		ELSIF v_value19 = '10' THEN v_request_department := '산부인과';
		ELSIF v_value19 = '11' THEN v_request_department := '소아과';
		ELSIF v_value19 = '12' THEN v_request_department := '안과';
		ELSIF v_value19 = '13' THEN v_request_department := '이비인후과';
		ELSIF v_value19 = '14' THEN v_request_department := '피부과';
		ELSIF v_value19 = '15' THEN v_request_department := '비뇨기과';
		ELSIF v_value19 = '16' THEN v_request_department := '진단방사선과';
		ELSIF v_value19 = '17' THEN v_request_department := '치료방사선과';
		ELSIF v_value19 = '18' THEN v_request_department := '해부병리과';
		ELSIF v_value19 = '19' THEN v_request_department := '임상병리과';
		ELSIF v_value19 = '20' THEN v_request_department := '결핵과';
		ELSIF v_value19 = '21' THEN v_request_department := '재활의학과';
		ELSIF v_value19 = '22' THEN v_request_department := '핵의학과';
		ELSIF v_value19 = '23' THEN v_request_department := '가정의학과';
		ELSIF v_value19 = '24' THEN v_request_department := '응급의학과';
		ELSIF v_value19 = '25' THEN v_request_department := '산업의학과';
		ELSE  v_request_department := '';
		END IF;			

		v_m_patient_id_issuer			:= NULL;
		v_m_last_name					:= NULL;
		v_m_first_name					:= NULL;
		v_m_middle_name					:= NULL;
		v_m_prefix						:= NULL;
		v_m_suffix						:= NULL;
		v_m_race_code					:= NULL;
		v_m_account_no					:= NULL;
		v_m_address						:= NULL;
		v_m_order_entry_user_id			:= NULL;
		v_m_order_entry_location		:= NULL;
		v_m_order_callback_phone_no		:= NULL;
		v_m_req_proc_status				:= NULL;
		v_m_req_proc_code_scheme		:= NULL;
		v_m_req_proc_code_version		:= NULL;
		v_m_req_proc_code_meaning		:= NULL;
		v_m_req_proc_location			:= NULL;
		v_m_patient_arrange				:= NULL;
		v_m_source_aetitle				:= v_scheduled_aetitle;
		v_m_broker_aetitle				:= v_broker_aetitle;
		v_m_broker_type					:= 'ODBC';
		v_m_study_ssn					:= NULL;

	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE text_to_report
	(
		v_broker_aetitle				IN VARCHAR2,
		v_value01						IN VARCHAR2, 
		v_value02						IN VARCHAR2, 
		v_value03						IN VARCHAR2, 
		v_value04						IN VARCHAR2, 
		v_value05						IN VARCHAR2, 
		v_value06						IN VARCHAR2, 
		v_value07						IN VARCHAR2, 
		v_value08						IN VARCHAR2, 
		v_value09						IN VARCHAR2, 
		v_value10						IN VARCHAR2, 
		v_value11						IN VARCHAR2, 
		v_value12						IN VARCHAR2, 
		v_value13						IN VARCHAR2, 
		v_value14						IN VARCHAR2, 
		v_value15						IN VARCHAR2, 
		v_value16						IN VARCHAR2, 
		v_value17						IN VARCHAR2, 
		v_value18						IN VARCHAR2, 
		v_value19						IN VARCHAR2, 
		v_value20						IN VARCHAR2, 
		v_value21						IN VARCHAR2, 
		v_value22						IN VARCHAR2, 
		v_value23						IN VARCHAR2, 
		v_value24						IN VARCHAR2, 
		v_value25						IN VARCHAR2, 
		v_value26						IN VARCHAR2, 
		v_value27						IN VARCHAR2, 
		v_value28						IN VARCHAR2, 
		v_value29						IN VARCHAR2, 
		v_value30						IN VARCHAR2, 
		v_value31						IN VARCHAR2, 
		v_value32						IN VARCHAR2, 
		v_value33						IN VARCHAR2, 
		v_value34						IN VARCHAR2, 
		v_value35						IN VARCHAR2, 
		v_value36						IN VARCHAR2, 
		v_value37						IN VARCHAR2, 
		v_value38						IN VARCHAR2, 
		v_value39						IN VARCHAR2, 
		v_value40						IN VARCHAR2, 

		v_patient_id					OUT VARCHAR2,
		v_exam_id						OUT VARCHAR2,
		v_study_instance_uid			OUT VARCHAR2,
		v_report_stat					OUT VARCHAR2,
		v_creator_id					OUT VARCHAR2,
		v_creator_name					OUT VARCHAR2,
		v_create_dttm					OUT VARCHAR2,
		v_dictator_id					OUT VARCHAR2,
		v_dictator_name					OUT VARCHAR2,
		v_dictate_dttm					OUT VARCHAR2,
		v_transcriber_id				OUT VARCHAR2,
		v_transcriber_name				OUT VARCHAR2,
		v_transcribe_dttm				OUT VARCHAR2,
		v_approver_id					OUT VARCHAR2,
		v_approver_name					OUT VARCHAR2,
		v_approve_dttm					OUT VARCHAR2,
		v_reviser_id					OUT VARCHAR2,
		v_reviser_name					OUT VARCHAR2,
		v_revise_dttm					OUT VARCHAR2,
		v_report_type					OUT VARCHAR2,
		v_report_text					OUT LONG,
		v_conclusion					OUT LONG,
		v_study_dttm					OUT VARCHAR2,
		v_scheduled_location			OUT VARCHAR2,
		v_perform_department			OUT VARCHAR2,
		v_perform_modality				OUT VARCHAR2,
		v_request_dttm					OUT VARCHAR2,
		v_request_name					OUT VARCHAR2,
		v_request_code					OUT VARCHAR2,
		v_request_doctor				OUT VARCHAR2,
		v_perform_doctor				OUT VARCHAR2,
		v_refer_doctor					OUT VARCHAR2,
		v_scheduled_dttm				OUT VARCHAR2,
		v_patient_name					OUT VARCHAR2,
		v_patient_sex					OUT VARCHAR2,
		v_patient_birth_dttm			OUT VARCHAR2,
		v_admission_id					OUT VARCHAR2,
		v_study_comments				OUT VARCHAR2,
		v_study_reason					OUT VARCHAR2,
		v_attend_doctor					OUT VARCHAR2,
		v_r_event_type					OUT	VARCHAR2,
		v_r_report_control_id			OUT	VARCHAR2,
		v_r_broker_type					OUT	VARCHAR2
	)
	IS
	BEGIN
	
		v_patient_id 					:= rtrim(v_value01);
		v_exam_id						:= rtrim(v_value02);
		v_study_instance_uid			:= rtrim(v_value03);
		v_report_stat					:= rtrim(v_value04);
		v_creator_id					:= rtrim(v_value05);
		v_creator_name					:= rtrim(v_value06);
		v_create_dttm					:= rtrim(v_value07);
		v_dictator_id					:= rtrim(v_value08);
		v_dictator_name					:= rtrim(v_value09);
		v_dictate_dttm					:= rtrim(v_value10);
		v_transcriber_id				:= rtrim(v_value11);
		v_transcriber_name				:= rtrim(v_value12);
		v_transcribe_dttm				:= rtrim(v_value13);
		v_approver_id					:= rtrim(v_value14);
		v_approver_name					:= rtrim(v_value15);
		v_approve_dttm					:= rtrim(v_value16);
		v_reviser_id					:= rtrim(v_value17);
		v_reviser_name					:= rtrim(v_value18);
		v_revise_dttm					:= rtrim(v_value19);
		v_report_type					:= rtrim(v_value20);
		v_report_text					:= rtrim(v_value21);
		v_conclusion					:= rtrim(v_value22);
		v_study_dttm					:= rtrim(v_value23);
		v_scheduled_location			:= rtrim(v_value24);
		v_perform_department			:= rtrim(v_value25);
		v_perform_modality				:= rtrim(v_value26);
		v_request_dttm					:= rtrim(v_value27);
		v_request_name					:= rtrim(v_value28);
		v_request_code					:= rtrim(v_value29);
		v_request_doctor				:= rtrim(v_value30);
		v_perform_doctor				:= rtrim(v_value31);
		v_refer_doctor					:= rtrim(v_value32);
		v_scheduled_dttm				:= rtrim(v_value33);
		v_patient_name					:= rtrim(v_value34);
		v_patient_sex					:= rtrim(v_value35);
		v_patient_birth_dttm			:= rtrim(v_value36);
		v_admission_id					:= rtrim(v_value37);
		v_study_comments				:= rtrim(v_value38);
		v_study_reason					:= rtrim(v_value39);
		v_attend_doctor					:= rtrim(v_value40);

		v_r_event_type					:= NULL;
		v_r_report_control_id			:= NULL;
		v_r_broker_type					:= 'ODBC';

	END;	

	-------------------------------------------------------------------------------------------------
	PROCEDURE study_to_text
	(
		v_broker_aetitle				IN	VARCHAR2,
		v_study_key						IN	NUMBER,
		v_patient_id					IN	VARCHAR2,
		v_exam_id						IN	VARCHAR2,
		v_study_stat					IN	VARCHAR2,
		v_study_instance_uid			IN	VARCHAR2,
		v_study_dttm					IN	VARCHAR2,
		v_request_code					IN	VARCHAR2,
		v_request_name					IN	VARCHAR2,
		v_perform_modality				IN	VARCHAR2,
		v_perform_department			IN	VARCHAR2,
		v_perform_station				IN	VARCHAR2,
		v_source_aetitle				IN	VARCHAR2,
		v_scheduled_location			IN	VARCHAR2,
		v_scheduled_dttm				IN	VARCHAR2,
		v_patient_location				IN	VARCHAR2,
		v_request_dttm					IN	VARCHAR2,
		v_study_desc					IN	VARCHAR2,
		v_bodyparts						IN	VARCHAR2,

		v_value01						OUT VARCHAR2, 
		v_value02						OUT VARCHAR2, 
		v_value03						OUT VARCHAR2, 
		v_value04						OUT VARCHAR2, 
		v_value05						OUT VARCHAR2, 
		v_value06						OUT VARCHAR2, 
		v_value07						OUT VARCHAR2, 
		v_value08						OUT VARCHAR2, 
		v_value09						OUT VARCHAR2, 
		v_value10						OUT VARCHAR2, 
		v_value11						OUT VARCHAR2, 
		v_value12						OUT VARCHAR2, 
		v_value13						OUT VARCHAR2, 
		v_value14						OUT VARCHAR2, 
		v_value15						OUT VARCHAR2, 
		v_value16						OUT VARCHAR2, 
		v_value17						OUT VARCHAR2, 
		v_value18						OUT VARCHAR2, 
		v_value19						OUT VARCHAR2, 
		v_value20						OUT VARCHAR2, 
		v_value21						OUT VARCHAR2, 
		v_value22						OUT VARCHAR2, 
		v_value23						OUT VARCHAR2, 
		v_value24						OUT VARCHAR2, 
		v_value25						OUT VARCHAR2, 
		v_value26						OUT VARCHAR2, 
		v_value27						OUT VARCHAR2, 
		v_value28						OUT VARCHAR2, 
		v_value29						OUT VARCHAR2, 
		v_value30						OUT VARCHAR2, 
		v_value31						OUT VARCHAR2, 
		v_value32						OUT VARCHAR2, 
		v_value33						OUT VARCHAR2, 
		v_value34						OUT VARCHAR2, 
		v_value35						OUT VARCHAR2, 
		v_value36						OUT VARCHAR2, 
		v_value37						OUT VARCHAR2, 
		v_value38						OUT VARCHAR2, 
		v_value39						OUT VARCHAR2, 
		v_value40						OUT VARCHAR2
	)
	IS
	BEGIN
		v_value01 := to_char(v_study_key);
		v_value02 := v_patient_id;
		v_value03 := v_exam_id;
		v_value04 := v_study_stat;
		v_value05 := v_study_instance_uid;
		v_value06 := v_study_dttm;
		v_value07 := v_request_code;
		v_value08 := v_request_name;
		v_value09 := v_perform_modality;
		v_value10 := v_perform_department;
		v_value11 := v_perform_station;	
		v_value12 := v_source_aetitle;
		v_value13 := v_scheduled_location;
		v_value14 := v_scheduled_dttm;
		v_value15 := v_patient_location;
		v_value16 := v_request_dttm;
		v_value17 := v_study_desc;
		v_value18 := v_bodyparts;
		v_value19 := NULL;
		v_value20 := NULL;
		v_value21 := NULL;
		v_value22 := NULL;
		v_value23 := NULL;
		v_value24 := NULL;
		v_value25 := NULL;
		v_value26 := NULL;
		v_value27 := NULL;
		v_value28 := NULL;
		v_value29 := NULL;
		v_value30 := NULL;
		v_value31 := NULL;
		v_value32 := NULL;
		v_value33 := NULL;
		v_value34 := NULL;
		v_value35 := NULL;
		v_value36 := NULL;
		v_value37 := NULL;
		v_value38 := NULL;
		v_value39 := NULL;
		v_value40 := NULL;
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE report_to_text
	(
		v_broker_aetitle				IN	VARCHAR2,
		v_report_key					IN  NUMBER,
		v_patient_id					IN  VARCHAR2,
		v_exam_id						IN  VARCHAR2,
		v_study_instance_uid			IN  VARCHAR2,
		v_report_stat					IN  VARCHAR2,
		v_creator_id					IN  VARCHAR2,
		v_creator_name					IN  VARCHAR2,
		v_create_dttm					IN  VARCHAR2,
		v_dictator_id					IN  VARCHAR2,		-- 10
		v_dictator_name					IN  VARCHAR2,
		v_dictate_dttm					IN  VARCHAR2,
		v_transcriber_id				IN  VARCHAR2,
		v_transcriber_name				IN  VARCHAR2,
		v_transcribe_dttm				IN  VARCHAR2,
		v_approver_id					IN  VARCHAR2,
		v_approver_name					IN  VARCHAR2,
		v_approve_dttm					IN  VARCHAR2,
		v_reviser_id					IN  VARCHAR2,
		v_reviser_name					IN  VARCHAR2,		-- 20
		v_revise_dttm					IN  VARCHAR2,
		v_report_type					IN  VARCHAR2, 
		v_report_text					IN  LONG,
		v_conclusion					IN  LONG,
		v_study_dttm					IN  VARCHAR2,
		v_scheduled_location			IN  VARCHAR2,
		v_perform_department			IN  VARCHAR2,
		v_perform_modality				IN  VARCHAR2,
		v_request_dttm					IN  VARCHAR2,
		v_request_name					IN  VARCHAR2,		-- 30
		v_request_code					IN  VARCHAR2,
		v_request_doctor				IN  VARCHAR2,
		v_perform_doctor				IN  VARCHAR2,
		v_refer_doctor					IN  VARCHAR2,
		v_scheduled_dttm				IN  VARCHAR2,
		v_patient_name					IN  VARCHAR2,
		v_patient_sex					IN  VARCHAR2,
		v_patient_birth_dttm			IN  VARCHAR2,
		v_admission_id					IN  VARCHAR2,
		v_study_comments				IN  VARCHAR2,		-- 40
		v_study_reason					IN  VARCHAR2,
		v_attend_doctor					IN  VARCHAR2,
		v_patient_location				IN  VARCHAR2,
		v_scheduled_station				IN  VARCHAR2,
		v_fxcode						IN  VARCHAR2,
		v_fxdesc						IN  VARCHAR2,
		v_dxcode						IN  VARCHAR2,
		v_dxdesc						IN  VARCHAR2,		-- 48
		
		v_value01						OUT VARCHAR2,
		v_value02						OUT VARCHAR2,
		v_value03						OUT VARCHAR2,
		v_value04						OUT VARCHAR2,
		v_value05						OUT VARCHAR2,
		v_value06						OUT VARCHAR2,
		v_value07						OUT VARCHAR2,
		v_value08						OUT VARCHAR2,
		v_value09						OUT VARCHAR2,
		v_value10						OUT VARCHAR2,
		v_value11						OUT VARCHAR2,
		v_value12						OUT VARCHAR2,
		v_value13						OUT VARCHAR2,
		v_value14						OUT VARCHAR2,
		v_value15						OUT VARCHAR2,
		v_value16						OUT VARCHAR2,
		v_value17						OUT VARCHAR2,
		v_value18						OUT VARCHAR2,
		v_value19						OUT VARCHAR2,
		v_value20						OUT VARCHAR2,
		v_value21						OUT LONG,
		v_value22						OUT LONG,
		v_value23						OUT VARCHAR2,
		v_value24						OUT VARCHAR2,
		v_value25						OUT VARCHAR2,
		v_value26						OUT VARCHAR2,
		v_value27						OUT VARCHAR2,
		v_value28						OUT VARCHAR2,
		v_value29						OUT VARCHAR2,
		v_value30						OUT VARCHAR2,
		v_value31						OUT VARCHAR2,
		v_value32						OUT VARCHAR2,
		v_value33						OUT VARCHAR2,
		v_value34						OUT VARCHAR2,
		v_value35						OUT VARCHAR2,
		v_value36						OUT VARCHAR2,
		v_value37						OUT VARCHAR2,
		v_value38						OUT VARCHAR2,
		v_value39						OUT VARCHAR2,
		v_value40						OUT VARCHAR2
	)
	IS
	BEGIN

		v_value01 := v_patient_id;
		v_value02 := v_exam_id;
		v_value03 := v_study_instance_uid;
		v_value04 := v_report_stat;
		v_value05 := v_creator_id;
		v_value06 := v_creator_name;
		v_value07 := v_create_dttm;
		v_value08 := v_dictator_id;
		v_value09 := v_dictator_name;
		v_value10 := v_dictate_dttm;
		v_value11 := v_transcriber_id;
		v_value12 := v_transcriber_name;
		v_value13 := v_transcribe_dttm;
		v_value14 := v_approver_id;
		v_value15 := v_approver_name;
		v_value16 := v_approve_dttm;
		v_value17 := v_reviser_id;
		v_value18 := v_reviser_name;
		v_value19 := v_revise_dttm;
		v_value20 := v_report_type;
		v_value21 := v_report_text;
		v_value22 := v_conclusion;
		v_value23 := v_study_dttm;
		v_value24 := v_scheduled_location;
		v_value25 := v_perform_department;
		v_value26 := v_perform_modality;
		v_value27 := v_request_dttm;
		v_value28 := v_request_name;
		v_value29 := v_request_code;
		v_value30 := v_request_doctor;
		v_value31 := v_perform_doctor;
		v_value32 := v_refer_doctor;
		v_value33 := v_scheduled_dttm;
		v_value34 := v_patient_name;
		v_value35 := v_patient_sex;
		v_value36 := v_patient_birth_dttm;
		v_value37 := v_admission_id;
		v_value38 := v_study_comments;
		v_value39 := v_study_reason;
		v_value40 := v_attend_doctor;
/*
-- for Taiwan Minsung Hospital.
		v_value01 := v_exam_id;
		v_value02 := v_patient_id;     
	 	v_value03 := SUBSTR(v_approve_dttm, 1, 8);
		v_value04 := SUBSTR(v_approve_dttm, 9, 4);		
		v_value05 := v_approver_id;
		v_value06 := v_report_text;		
		
-- for Singapore Parkway.
		SELECT patient_residency, scheduled_dttm, admit_dttm
		  INTO v_value17, v_value18, v_value20
		  FROM mwl 
		 WHERE study_instance_uid = v_study_instance_uid;

		v_value01 := v_patient_id;
		v_value02 := v_exam_id;
		v_value03 := v_patient_name;
		v_value04 := NULL; 
		v_value05 := v_patient_birth_dttm;
		v_value06 := v_patient_sex;
		v_value07 := v_patient_location;
		v_value08 := v_perform_modality;
		v_value09 := v_perform_modality;
		v_value10 := v_exam_id;
		v_value11 := v_request_name;
		v_value12 := NULL;
		v_value13 := v_request_doctor;
		v_value14 := NULL;
		v_value15 := v_refer_doctor;
		v_value16 := v_perform_department;
		--v_value17 := NULL;
		--v_value18 := NULL;
		v_value19 := v_study_dttm;
		--v_value20 := NULL;
		v_value21 := NULL;
		v_value22 := NULL;
		v_value23 := v_approve_dttm;
		v_value24 := NULL;
		v_value25 := NULL;
		v_value26 := v_approver_id;
		v_value27 := v_approver_name;
		v_value28 := NULL;
		v_value29 := NULL;
		v_value30 := NULL;
		v_value31 := NULL;
		v_value32 := NULL;
		v_value33 := v_conclusion;
		v_value34 := v_transcriber_id;
		v_value35 := v_transcriber_name;
		v_value36 := NULL;
		v_value37 := NULL;
		v_value38 := 'ORU';
		v_value39 := 'UPD';
		v_value40 := '38';    
*/		 
 
	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE study_to_study
	(
		v_broker_aetitle				IN OUT	VARCHAR2,
		v_StudyKey						IN OUT  NUMBER,
		v_StudyInstanceUID				IN OUT	VARCHAR2,
		v_QueueStat						IN OUT	VARCHAR2,
		v_MatchStat						IN OUT	VARCHAR2,
		v_PatientId						IN OUT	VARCHAR2,
		v_ExamId						IN OUT	VARCHAR2,
		v_StudyStat       				IN OUT	VARCHAR2,
		v_StudyDttm						IN OUT	VARCHAR2,
		v_RequestCode					IN OUT	VARCHAR2,	-- 10
		v_RequestName					IN OUT	VARCHAR2,
		v_PerformModality               IN OUT	VARCHAR2,
		v_PerformDepartment 			IN OUT	VARCHAR2,
		v_PerformStation				IN OUT	VARCHAR2,
		v_SourceAETitle					IN OUT	VARCHAR2,
		v_ScheduledLocation				IN OUT	VARCHAR2,
		v_ScheduledDttm					IN OUT	VARCHAR2,
		v_PatientLocation				IN OUT	VARCHAR2,
		v_RequestDttm					IN OUT	VARCHAR2,
		v_StudyDesc						IN OUT	VARCHAR2,	-- 20
		v_Bodyparts						IN OUT	VARCHAR2,
		v_ScheduledProcStatus			IN OUT	VARCHAR2,
		v_ScheduledProcId				IN OUT	VARCHAR2,
		v_ScheduledProcDesc				IN OUT	VARCHAR2,
		v_PatientName					IN OUT	VARCHAR2,
		v_PatientSex					IN OUT	VARCHAR2,
		v_AdmissionId					IN OUT	VARCHAR2,
		v_SeriesCount					IN OUT  NUMBER,
		v_InstanceCount					IN OUT  NUMBER,		-- 29
		v_ObjectType					IN OUT  VARCHAR2,

		v_oru_field1					OUT	VARCHAR2,
		v_oru_field2					OUT	VARCHAR2,
		v_oru_field3					OUT	VARCHAR2,
		v_oru_field4					OUT	VARCHAR2,
		v_oru_field5					OUT	VARCHAR2,
		v_oru_field6					OUT	VARCHAR2,
		v_oru_field7					OUT	VARCHAR2,
		v_oru_field8					OUT	VARCHAR2,
		v_oru_field9					OUT	VARCHAR2,
		v_oru_field10					OUT	VARCHAR2
	)
	IS

	BEGIN

 		v_StudyInstanceUID				:= v_StudyInstanceUID;
		v_QueueStat						:= v_QueueStat;
		v_MatchStat						:= v_MatchStat;
		v_PatientId						:= v_PatientId;
		v_ExamId						:= v_ExamId;
		v_StudyStat						:= v_StudyStat;
		v_StudyDttm						:= v_StudyDttm;
		v_RequestCode					:= v_RequestCode;
		v_RequestName					:= v_RequestName;
		v_PerformModality				:= v_PerformModality;
		v_PerformDepartment 			:= v_PerformDepartment;
		v_PerformStation				:= v_PerformStation;
		v_SourceAETitle					:= v_SourceAETitle;
		v_ScheduledLocation				:= v_ScheduledLocation;
		v_ScheduledDttm					:= v_ScheduledDttm;
		v_PatientLocation				:= v_PatientLocation;
		v_RequestDttm					:= v_RequestDttm;
		v_StudyDesc						:= v_StudyDesc;
		v_Bodyparts						:= v_Bodyparts;
		v_ScheduledProcStatus			:= v_ScheduledProcStatus;
		v_ScheduledProcId				:= v_ScheduledProcId;
		v_ScheduledProcDesc				:= v_ScheduledProcDesc;
		v_PatientName					:= v_PatientName;
		v_PatientSex					:= v_PatientSex;
		v_AdmissionId					:= v_AdmissionId;
		v_SeriesCount					:= v_SeriesCount;
		v_InstanceCount					:= v_InstanceCount;
		v_ObjectType					:= v_ObjectType;

		-- for HL7
		v_oru_field1			:= '';
		v_oru_field2			:= '';
		v_oru_field3			:= '';
		v_oru_field4			:= '';
		v_oru_field5			:= '';
		v_oru_field6			:= '';
		v_oru_field7			:= '';
		v_oru_field8			:= '';
		v_oru_field9			:= '';
		v_oru_field10			:= '';

	END;

	-------------------------------------------------------------------------------------------------
	PROCEDURE examresult_to_text
	(
		v_broker_aetitle					IN	VARCHAR2,
		v_hostname						IN VARCHAR2,
		v_trigger_dttm					IN VARCHAR2,
		v_patient_id						IN	VARCHAR2,
		v_patinet_name					IN VARCHAR2,
		v_study_dttm					IN	VARCHAR2,
		v_study_instance_uid		IN	VARCHAR2,
		v_accession_number			IN VARCHAR2,
		v_department_code			IN VARCHAR2,
		v_department_name			IN VARCHAR2,
		v_patient_location				IN	VARCHAR2,
		v_study_desc					IN	VARCHAR2,
		v_modality_code					IN  VARCHAR2,
		v_object_type					IN VARCHAR2,
		v_message_type					IN VARCHAR2,		

		v_value01						OUT VARCHAR2,
		v_value02						OUT VARCHAR2,
		v_value03						OUT VARCHAR2,
		v_value04						OUT VARCHAR2,
		v_value05						OUT VARCHAR2,
		v_value06						OUT VARCHAR2,
		v_value07						OUT VARCHAR2,
		v_value08						OUT VARCHAR2,
		v_value09						OUT VARCHAR2,
		v_value10						OUT VARCHAR2,
		v_value11						OUT VARCHAR2,
		v_value12						OUT VARCHAR2,
		v_value13						OUT VARCHAR2,
		v_value14						OUT VARCHAR2,
		v_value15						OUT VARCHAR2,
		v_value16						OUT VARCHAR2,
		v_value17						OUT VARCHAR2,
		v_value18						OUT VARCHAR2,
		v_value19						OUT VARCHAR2,
		v_value20						OUT VARCHAR2,
		v_value21						OUT VARCHAR2,
		v_value22						OUT VARCHAR2,
		v_value23						OUT VARCHAR2,
		v_value24						OUT VARCHAR2,
		v_value25						OUT VARCHAR2,
		v_value26						OUT VARCHAR2,
		v_value27						OUT VARCHAR2,
		v_value28						OUT VARCHAR2,
		v_value29						OUT VARCHAR2,
		v_value30						OUT VARCHAR2,
		v_value31						OUT VARCHAR2,
		v_value32						OUT VARCHAR2,
		v_value33						OUT VARCHAR2,
		v_value34						OUT VARCHAR2,
		v_value35						OUT VARCHAR2,
		v_value36						OUT VARCHAR2,
		v_value37						OUT VARCHAR2,
		v_value38						OUT VARCHAR2,
		v_value39						OUT VARCHAR2,
		v_value40						OUT VARCHAR2
	)
	IS

	BEGIN
		v_value01	:= v_broker_aetitle;
		v_value02	:= v_hostname;
		v_value03	:= v_trigger_dttm;
		v_value04	:= v_patient_id;
		v_value05	:= v_patinet_name;
		v_value06	:= v_study_dttm;
		v_value07	:= v_study_instance_uid;
		v_value08	:= v_accession_number;
		v_value09	:= v_department_code;
		v_value10	:= v_department_name;
		v_value11	:= v_patient_location;
		v_value12	:= v_study_desc; 
		v_value13   := v_modality_code;
		v_value14   := v_object_type;
		v_value15   := v_message_type;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION version
	RETURN VARCHAR2
	IS
		v_workfile			VARCHAR2(64);
		v_revision			VARCHAR2(64);
		v_date				VARCHAR2(64);
	BEGIN
		v_workfile := ltrim(rtrim(translate('$Workfile: PbdScript-SAMPLE.sql $', '$', ' ')));
		v_revision := ltrim(rtrim(translate('$Revision: 3 $', '$', ' ')));
		v_date := ltrim(rtrim(translate('$Date: 2010-11-22 $', '$', ' ')));
		RETURN v_workfile || ', ' || v_revision || ', ' || v_date;
	END;

	-------------------------------------------------------------------------------------------------

END;
/
SHOW ERRORS    