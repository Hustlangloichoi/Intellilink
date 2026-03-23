-------------------------------------------------------------------------------------------------
--	Copyright (c) INFINITT Co., Ltd.
--	All Rights Reserved
-------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE sp_mapper
AS
-------------------------------------------------------------------------------------------------
-- call fuction by BROKER
-- Integration fuction for HL7 and ODBC
-------------------------------------------------------------------------------------------------
	FUNCTION put_patient
	(
		v_event_type					IN VARCHAR2, 
		v_patient_id					IN VARCHAR2,
		v_prior_patient_id				IN VARCHAR2 := NULL,
		v_patient_id_issuer_code		IN VARCHAR2 := NULL,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2 := NULL,
		v_first_name					IN VARCHAR2 := NULL,
		v_middle_name					IN VARCHAR2 := NULL,
		v_prefix						IN VARCHAR2 := NULL,		--10
		v_suffix						IN VARCHAR2 := NULL,
		v_marital_stat					IN VARCHAR2 := NULL,
		v_confidentiality				IN VARCHAR2 := NULL,
		v_patient_birth_dttm			IN VARCHAR2 := NULL,
		v_patient_death_dttm			IN VARCHAR2 := NULL,
		v_patient_sex					IN VARCHAR2 := NULL,
		v_patient_size					IN VARCHAR2 := NULL,
		v_patient_weight				IN VARCHAR2 := NULL,
		v_blood_type_abo				IN VARCHAR2 := NULL,
		v_blood_type_rh					IN VARCHAR2 := NULL,		--20
		v_citizenship					IN VARCHAR2 := NULL,
		v_occupation					IN VARCHAR2 := NULL,
		v_race_code						IN VARCHAR2 := NULL,
		v_language_code					IN VARCHAR2 := NULL,
		v_religion_code					IN VARCHAR2 := NULL,
		v_birthplace					IN VARCHAR2 := NULL,
		v_multiple_birth_status			IN VARCHAR2 := NULL,
		v_birth_order					IN VARCHAR2 := NULL,
		v_email							IN VARCHAR2 := NULL,
		v_phone_no						IN VARCHAR2 := NULL,		--30
		v_pregnancy_code				IN VARCHAR2 := NULL,
		v_patient_stat					IN VARCHAR2 := NULL,
		v_account_no					IN VARCHAR2 := NULL,
		v_contact_type					IN VARCHAR2 := NULL,
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL,
		v_fax_no						IN VARCHAR2 := NULL,
		v_address						IN VARCHAR2 := NULL,
		v_city							IN VARCHAR2 := NULL,
		v_state							IN VARCHAR2 := NULL,		--40
		v_country						IN VARCHAR2 := NULL,
		v_zipcode						IN VARCHAR2 := NULL,
		v_visit_number					IN VARCHAR2,
		v_visit_stat					IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2 := NULL,
		v_discharge_dttm				IN VARCHAR2 := NULL,
		v_patient_location				IN VARCHAR2 := NULL,
		v_patient_residence				IN VARCHAR2 := NULL,
		v_refer_doctor_id				IN VARCHAR2 := NULL,
		v_consult_doctor_id				IN VARCHAR2 := NULL,		--50
		v_institution_code				IN VARCHAR2 := NULL,
		v_visit_comment					IN VARCHAR2 := NULL,
		v_admit_route					IN VARCHAR2 := NULL,
		v_lastmen_strual_dttm			IN VARCHAR2 := NULL,
		v_pregnancy_status	 			IN VARCHAR2 := NULL,
		v_code_abbreviation				IN VARCHAR2 := NULL,
		v_station_code					IN VARCHAR2 := NULL,
		v_english_name					IN VARCHAR2	:= NULL,
		v_ethnic_group					IN VARCHAR2	:= NULL,
		v_current_department			IN VARCHAR2	:= NULL,		--60
		v_refer_doctor_name				IN VARCHAR2	:= NULL,
		v_consult_doctor_name			IN VARCHAR2	:= NULL,
		v_broker_aetitle				IN VARCHAR2	:= NULL,
		v_broker_type					IN VARCHAR2	:= NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_order
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_id_issuer_code		IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,				--10
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_race_code						IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,	
		v_account_no					IN VARCHAR2,
		v_address						IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,				--20
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,   
		v_access_no						IN VARCHAR2,
		v_order_stat					IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_comments				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,				--30
		v_order_entry_location			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,
		v_attend_doctor_id				IN VARCHAR2,
		v_perform_doctor_id				IN VARCHAR2,
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_id					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,				--40
		v_reqproc_code_meaning			IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_reqproc_comments				IN VARCHAR2,
		v_reqproc_priority				IN VARCHAR2,
		v_reqproc_location				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2,
		v_diagnosis						IN VARCHAR2	:= NULL,
		v_other_patient_id				IN VARCHAR2	:= NULL,
		v_other_patient_name			IN VARCHAR2	:= NULL,		--50
		v_source_aetitle				IN VARCHAR2	:= NULL,
		v_broker_aetitle				IN VARCHAR2	:= NULL,
		v_broker_type					IN VARCHAR2	:= NULL,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_diagnosis_code				IN VARCHAR2 := NULL,
		v_diagnosis_code_meaning		IN VARCHAR2 := NULL,
		v_note_and_comments				IN VARCHAR2 := NULL,
		v_sending_facility				IN VARCHAR2 := NULL,
		v_patient_weight          		IN VARCHAR2 := NULL,
		v_patient_size          		IN VARCHAR2 := NULL,		--60
		v_vet_sex_neutered		IN VARCHAR2 := NULL,
		v_species_code_description	IN VARCHAR2 := NULL,
		v_breed_code_description	IN VARCHAR2 := NULL,
		v_nk1_name		IN VARCHAR2 := NULL,
		v_nk1_relationship		IN VARCHAR2 := NULL,
		v_nk1_organization_name		IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_order_crosswalk
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_vendor						IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,				--10
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_refer_doctor_name				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_hl7_orm_msg					IN VARCHAR2,
		v_orm_stat						IN VARCHAR2,
		v_msg_file_name					IN VARCHAR2,
		v_access_no						IN VARCHAR2
	)
	RETURN NUMBER;
	------------------------------------------------------------------------------------------------
	FUNCTION put_order_crosswalk_ex
	(
		v_vendor					IN xpatient.vendor%TYPE,
		--xpatient	
		v_vendor_pat_id				IN xpatient.vendor_pat_id%TYPE,
		v_patient_name				IN xpatient.patient_name%TYPE,
		v_dob 						IN VARCHAR2,
		v_sex						IN xpatient.sex%TYPE,
		v_ssn						IN xpatient.ssn%TYPE,
		--xphysician
		v_vendor_phy_id				IN xphysician.vendor_phy_id%TYPE,
		v_physician_name			IN xphysician.physician_name%TYPE,
		--xprocedure
		v_vendor_proc_code			IN xprocedure.vendor_proc_code%TYPE,
		v_procplan_desc				IN xprocedure.procplan_desc%TYPE,
		--xorm
		v_orm 						IN xorm.orm%TYPE,
		v_dttm						IN VARCHAR2,
		v_stat						IN xorm.stat%TYPE,
		v_msg_file_name				IN xorm.filename%TYPE,
		v_access_no					IN VARCHAR2,
		v_order_control_id			IN VARCHAR2
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps
	(
		v_study_key						IN NUMBER,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,					-- 10
		v_aetitle						IN VARCHAR2	:= NULL,
		v_scheduled_location			IN VARCHAR2	:= NULL,
		v_broker_type					IN VARCHAR2 := NULL,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_report
	(
		v_event_type						IN VARCHAR2,
		v_report_control_id					IN VARCHAR2,
		v_accession_no						IN VARCHAR2,
		v_patient_id						IN VARCHAR2,
		v_report_stat						IN VARCHAR2,
		v_creator_id						IN VARCHAR2,
		v_creator_name						IN VARCHAR2,
		v_create_dttm						IN VARCHAR2,
		v_dictator_id						IN VARCHAR2,
		v_dictator_name						IN VARCHAR2,				--10
		v_dictate_dttm						IN VARCHAR2,
		v_transcriber_id					IN VARCHAR2,
		v_transcriber_name					IN VARCHAR2,		
		v_transcribe_dttm					IN VARCHAR2,
		v_approver_id						IN VARCHAR2,
		v_approver_name						IN VARCHAR2,
		v_approve_dttm						IN VARCHAR2,
		v_reviser_id						IN VARCHAR2,
		v_reviser_name						IN VARCHAR2,
		v_revise_dttm						IN VARCHAR2,				--20
		v_report_type						IN VARCHAR2,
		v_report_text						IN LONG,
		v_conclusion						IN LONG,
		v_broker_type						IN VARCHAR2,
		v_put_report_type					IN VARCHAR2:=NULL,
		v_IsFirstReport						IN VARCHAR2:=NULL
	)
	RETURN NUMBER;
-------------------------------------------------------------------------------------------------
-- call fuction by BROKER
-- only for HL7
-------------------------------------------------------------------------------------------------
	FUNCTION put_patient_ex
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_prior_patient_id				IN VARCHAR2 := NULL,
		v_patient_id_issuer_code		IN VARCHAR2 := NULL,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2 := NULL,
		v_first_name					IN VARCHAR2 := NULL,
		v_middle_name					IN VARCHAR2 := NULL,
		v_prefix						IN VARCHAR2 := NULL,		--10
		v_suffix						IN VARCHAR2 := NULL,
		v_marital_stat					IN VARCHAR2 := NULL,
		v_confidentiality				IN VARCHAR2 := NULL,
		v_patient_birth_dttm			IN VARCHAR2 := NULL,
		v_patient_death_dttm			IN VARCHAR2 := NULL,
		v_patient_sex					IN VARCHAR2 := NULL,
		v_patient_size					IN VARCHAR2 := NULL,
		v_patient_weight				IN VARCHAR2 := NULL,
		v_blood_type_abo				IN VARCHAR2 := NULL,
		v_blood_type_rh					IN VARCHAR2 := NULL,		--20
		v_race_code						IN VARCHAR2 := NULL,
		v_email							IN VARCHAR2 := NULL,
		v_phone_no						IN VARCHAR2 := NULL,
		v_patient_stat					IN VARCHAR2 := NULL,
		v_account_no					IN VARCHAR2 := NULL,
	-- patientcontact
		v_contact_type					IN VARCHAR2 := NULL,
		v_fax_no						IN VARCHAR2 := NULL,
		v_address						IN VARCHAR2 := NULL,
		v_city							IN VARCHAR2 := NULL,
		v_state							IN VARCHAR2 := NULL,		--30
		v_country						IN VARCHAR2 := NULL,
		v_zipcode						IN VARCHAR2 := NULL,
	-- visit
		v_visit_number					IN VARCHAR2,
		v_visit_stat					IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2 := NULL,
		v_discharge_dttm				IN VARCHAR2 := NULL,
		v_patient_location				IN VARCHAR2 := NULL,
		v_patient_residence				IN VARCHAR2 := NULL,
		v_refer_doctor_id				IN VARCHAR2 := NULL,
		v_consult_doctor_id				IN VARCHAR2 := NULL,		--40
	-- order and msps
		v_code_abbreviation				IN VARCHAR2 := NULL,
		v_station_code					IN VARCHAR2 := NULL	
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_appointment
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
	-- patient
		v_patient_id					IN VARCHAR2,
		v_patient_id_issuer_code		IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,		--10
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_race_code						IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_account_no					IN VARCHAR2,
	-- patientcontact
		v_address						IN VARCHAR2,
	-- visit
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,		--20
	-- order
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,
		v_access_no						IN VARCHAR2,
		v_order_stat					IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_comments				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_doctor_last_name		IN VARCHAR2,
		v_order_doctor_first_name		IN VARCHAR2,		--30
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,
		v_order_entry_location			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,
	-- study
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_id					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,		--40
		v_reqproc_code_meaning			IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_reqproc_comments				IN VARCHAR2,
		v_reqproc_priority				IN VARCHAR2,
		v_reqproc_location				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2			--47
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	PROCEDURE put_patient_guarantor
	(
		--guarantor
		v_patient_key				IN VARCHAR2,
		v_gtr_relation_code_key		IN VARCHAR2 := NULL,
		v_guarantor_no				IN VARCHAR2 := NULL,
		v_gtr_last_name				IN VARCHAR2,
		v_gtr_first_name			IN VARCHAR2,
		v_gtr_middle_name			IN VARCHAR2 := NULL,
		v_gtr_prefix				IN VARCHAR2 := NULL,
		v_gtr_suffix				IN VARCHAR2 := NULL,
		v_guarantor_birth_dttm		IN VARCHAR2 := NULL,
		v_guarantor_sex				IN VARCHAR2 := NULL,
		v_guarantor_ssn				IN VARCHAR2 := NULL,
		v_gtr_phone_no				IN VARCHAR2 := NULL,
		v_gtr_fax_no				IN VARCHAR2 := NULL,
		v_gtr_address				IN VARCHAR2 := NULL,
		v_gtr_city					IN VARCHAR2 := NULL,
		v_gtr_state					IN VARCHAR2 := NULL,
		v_gtr_zipcode				IN VARCHAR2 := NULL,
		v_gtr_country				IN VARCHAR2 := NULL,
		v_gtr_emp_name				IN VARCHAR2 := NULL,
		v_gtr_emp_phone_no			IN VARCHAR2 := NULL,
		v_gtr_emp_fax_no			IN VARCHAR2 := NULL,
		v_gtr_emp_address			IN VARCHAR2 := NULL,
		v_gtr_emp_city				IN VARCHAR2 := NULL,
		v_gtr_emp_state				IN VARCHAR2 := NULL,
		v_gtr_emp_zipcode			IN VARCHAR2 := NULL,
		v_gtr_emp_country			IN VARCHAR2 := NULL,
		v_gtr_emp_comments			IN VARCHAR2 := NULL
	);
	-------------------------------------------------------------------------------------------------
	FUNCTION put_response
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
	-- order
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,		--10
	-- study
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,
		v_reqproc_code_meaning			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2			--18
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------
	PROCEDURE put_allergy
	(
		v_patient_key						IN NUMBER,
		v_index								IN NUMBER,
		v_allergen_type_code				IN VARCHAR2,
		v_allergen_code						IN VARCHAR2,
		v_allergen_desc						IN VARCHAR2,
		v_allergen_scheme					IN VARCHAR2,
		v_allergy_action_code				IN VARCHAR2,
		v_allergy_action_reason				IN VARCHAR2,
		v_allergy_clinical_status_code		IN VARCHAR2,
		v_allergy_clinical_status_desc		IN VARCHAR2,
		v_statused_by_person_id				IN VARCHAR2,
		v_statused_by_person_name			IN VARCHAR2,
		v_statused_by_person_issuer			IN VARCHAR2,
		v_statused_at_dttm					IN VARCHAR2,
		v_clinician_identified_code			IN VARCHAR2,
		v_clinician_identified_desc			IN VARCHAR2,
		v_clinician_identified_scheme		IN VARCHAR2,
		v_allergy_reaction_code_list		IN VARCHAR2,
		v_allergy_reaction_desc_list		IN VARCHAR2,
		v_allergy_severity_code_list		IN VARCHAR2,
		v_sens_causative_code_list			IN VARCHAR2
	);
	-------------------------------------------------------------------------------------------
	PROCEDURE put_patient_insurance
	(
		-- insurance
		v_patient_key				IN VARCHAR2,
		v_insurance_code			IN VARCHAR2 := NULL,
		v_insurance_name			IN VARCHAR2 := NULL,
		v_insurance_no				IN VARCHAR2 := NULL,
		v_health_plan				IN VARCHAR2 := NULL,
		v_policy_no					IN VARCHAR2,
		v_group_name				IN VARCHAR2 := NULL,
		v_group_no					IN VARCHAR2 := NULL,
		v_plan_effect_dttm			IN VARCHAR2 := NULL,
		v_plan_expire_dttm			IN VARCHAR2 := NULL,
		v_coord_code_key			IN VARCHAR2 := NULL,
		v_company_name				IN VARCHAR2,
		v_phone_no					IN VARCHAR2,
		v_fax_no					IN VARCHAR2 := NULL,
		v_address					IN VARCHAR2 := NULL,
		v_city						IN VARCHAR2 := NULL,
		v_state						IN VARCHAR2 := NULL,
		v_zipcode					IN VARCHAR2 := NULL,
		v_country					IN VARCHAR2 := NULL,
		v_relation_code_key			IN VARCHAR2 := NULL,
		v_insured_birth_dttm		IN VARCHAR2 := NULL,
		v_insured_sex				IN VARCHAR2 := NULL,
		v_insured_ssn				IN VARCHAR2 := NULL,
		v_last_name					IN VARCHAR2 := NULL,
		v_first_name				IN VARCHAR2 := NULL,
		v_middle_name				IN VARCHAR2 := NULL,
		v_prefix					IN VARCHAR2 := NULL,
		v_suffix					IN VARCHAR2 := NULL,
		v_insured_phone_no			IN VARCHAR2 := NULL,
		v_insured_fax_no   			IN VARCHAR2 := NULL,
		v_insured_address			IN VARCHAR2 := NULL,
		v_insured_city   			IN VARCHAR2 := NULL,
		v_insured_state   			IN VARCHAR2 := NULL,
		v_insured_zipcode			IN VARCHAR2 := NULL,
		v_insured_country			IN VARCHAR2 := NULL,
		v_insurance_type			IN VARCHAR2 := NULL
	);
	-------------------------------------------------------------------------------------------------
	FUNCTION put_mfn_user
	(
		v_broker_type					IN VARCHAR2,
		v_event_type					IN VARCHAR2,
		v_master_file_identifier		IN VARCHAR2,
		v_record_level_event_code		IN VARCHAR2,
		v_user_id						IN VARCHAR2,
		v_user_password					IN VARCHAR2,
		v_user_name						IN VARCHAR2,
		v_user_last_name				IN VARCHAR2,
		v_user_first_name				IN VARCHAR2,
		v_user_middle_name				IN VARCHAR2,
		v_user_prefix					IN VARCHAR2,
		v_user_suffix					IN VARCHAR2,
		v_user_level_code				IN VARCHAR2,
		v_user_stat						IN VARCHAR2,
		v_user_email					IN VARCHAR2,
		v_user_license_no				IN VARCHAR2,
		v_user_cell_phone_no			IN VARCHAR2,
		v_user_contact_type				IN VARCHAR2,
		v_user_home_phone_no			IN VARCHAR2,
		v_user_home_fax_no				IN VARCHAR2,
		v_user_home_address_1			IN VARCHAR2,
		v_user_home_address_2			IN VARCHAR2,
		v_user_home_city				IN VARCHAR2,
		v_user_home_state				IN VARCHAR2,
		v_user_home_zipcode				IN VARCHAR2,
		v_user_home_country				IN VARCHAR2,
		v_user_office_phone_no			IN VARCHAR2,
		v_user_office_fax_no			IN VARCHAR2,
		v_user_office_address_1			IN VARCHAR2,
		v_user_office_address_2			IN VARCHAR2,
		v_user_office_city				IN VARCHAR2,
		v_user_office_state				IN VARCHAR2,
		v_user_office_zipcode			IN VARCHAR2,
		v_user_office_country			IN VARCHAR2
	)
	RETURN users.user_key%TYPE;
-------------------------------------------------------------------------------------------------
-- call fuction by BROKER
-- only for ODBC
-------------------------------------------------------------------------------------------------
	FUNCTION put_user
	(
		v_user_id						IN VARCHAR2,
		v_user_name						IN VARCHAR2,
		v_password						IN VARCHAR2,
		v_user_level					IN VARCHAR2,
		v_user_status					IN VARCHAR2,
		v_comments						IN VARCHAR2
	)
	RETURN users.user_key%TYPE;
	-------------------------------------------------------------------------------------------
	PROCEDURE put_mwl
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_character_set					IN VARCHAR2,
		v_scheduled_aetitle				IN VARCHAR2,
		v_scheduled_dttm				IN VARCHAR2,
		v_scheduled_modality			IN VARCHAR2,
		v_scheduled_station				IN VARCHAR2,
		v_scheduled_location			IN VARCHAR2,
		v_scheduled_proc_id				IN VARCHAR2,
		v_scheduled_proc_desc			IN VARCHAR2,
		v_scheduled_action_codes		IN VARCHAR2,
		v_scheduled_proc_status			IN VARCHAR2,
		v_premedication					IN VARCHAR2,
		v_contrast_agent				IN VARCHAR2,
		v_requested_proc_id				IN VARCHAR2,
		v_requested_proc_desc			IN VARCHAR2,
		v_requested_proc_codes			IN VARCHAR2,
		v_requested_proc_priority		IN VARCHAR2,
		v_requested_proc_reason			IN VARCHAR2,
		v_requested_proc_comments		IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_proc_placer_order_no			IN VARCHAR2,
		v_proc_filler_order_no			IN VARCHAR2,
		v_accession_no					IN VARCHAR2,
		v_attend_doctor					IN VARCHAR2,
		v_perform_doctor				IN VARCHAR2,
		v_consult_doctor				IN VARCHAR2,
		v_request_doctor				IN VARCHAR2,
		v_refer_doctor					IN VARCHAR2,
		v_request_department			IN VARCHAR2,
		v_imaging_request_reason		IN VARCHAR2,
		v_imaging_request_comments		IN VARCHAR2,
		v_imaging_request_dttm			IN VARCHAR2,
		v_isr_placer_order_no			IN VARCHAR2,
		v_isr_filler_order_no			IN VARCHAR2,
		v_admission_id					IN VARCHAR2,
		v_patient_transport				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residency				IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_other_patient_name			IN VARCHAR2,
		v_other_patient_id				IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_patient_weight				IN VARCHAR2,
		v_patient_size					IN VARCHAR2,
		v_patient_state					IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_pregnancy_status				IN VARCHAR2,
		v_medical_alerts				IN VARCHAR2,
		v_contrast_allergies			IN VARCHAR2,
		v_special_needs					IN VARCHAR2,
		v_specialty						IN VARCHAR2,
		v_diagnosis						IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2,
		v_register_dttm					IN VARCHAR2,
		v_study_ssn						IN VARCHAR2
	);
-------------------------------------------------------------------------------------------------
-- processing for HL7 (PACS)
-------------------------------------------------------------------------------------------------
	FUNCTION put_patient_hl7_pacs
	(
		v_event_type					IN VARCHAR2, 
		v_patient_id					IN VARCHAR2,
		v_prior_patient_id				IN VARCHAR2 := NULL,
		v_patient_id_issuer_code		IN VARCHAR2 := NULL,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2 := NULL,
		v_first_name					IN VARCHAR2 := NULL,
		v_middle_name					IN VARCHAR2 := NULL,
		v_prefix						IN VARCHAR2 := NULL,
		v_suffix						IN VARCHAR2 := NULL,
		v_marital_stat					IN VARCHAR2 := NULL,
		v_confidentiality				IN VARCHAR2 := NULL,
		v_patient_birth_dttm			IN VARCHAR2 := NULL,
		v_patient_death_dttm			IN VARCHAR2 := NULL,
		v_patient_sex					IN VARCHAR2 := NULL,
		v_patient_size					IN VARCHAR2 := NULL,
		v_patient_weight				IN VARCHAR2 := NULL,
		v_blood_type_abo				IN VARCHAR2 := NULL,
		v_blood_type_rh					IN VARCHAR2 := NULL,
		v_citizenship					IN VARCHAR2 := NULL,
		v_occupation					IN VARCHAR2 := NULL,
		v_race_code						IN VARCHAR2 := NULL,
		v_language_code					IN VARCHAR2 := NULL,
		v_religion_code					IN VARCHAR2 := NULL,
		v_birthplace					IN VARCHAR2 := NULL,
		v_multiple_birth_status			IN VARCHAR2 := NULL,
		v_birth_order					IN VARCHAR2 := NULL,
		v_email							IN VARCHAR2 := NULL,
		v_phone_no						IN VARCHAR2 := NULL,
		v_pregnancy_code				IN VARCHAR2 := NULL,
		v_patient_stat					IN VARCHAR2 := NULL,
		v_account_no					IN VARCHAR2 := NULL,
		v_contact_type					IN VARCHAR2 := NULL,
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL,
		v_fax_no						IN VARCHAR2 := NULL,
		v_address						IN VARCHAR2 := NULL,
		v_city							IN VARCHAR2 := NULL,
		v_state							IN VARCHAR2 := NULL,
		v_country						IN VARCHAR2 := NULL,
		v_zipcode						IN VARCHAR2 := NULL,
		v_visit_number					IN VARCHAR2,
		v_visit_stat					IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2 := NULL,
		v_discharge_dttm				IN VARCHAR2 := NULL,
		v_patient_location				IN VARCHAR2 := NULL,
		v_patient_residence				IN VARCHAR2 := NULL,
		v_refer_doctor_id				IN VARCHAR2 := NULL,
		v_consult_doctor_id				IN VARCHAR2 := NULL,
		v_institution_code				IN VARCHAR2 := NULL,
		v_visit_comment					IN VARCHAR2 := NULL,
		v_admit_route					IN VARCHAR2 := NULL,
		v_lastmen_strual_dttm			IN VARCHAR2 := NULL,
		v_pregnancy_status				IN VARCHAR2 := NULL,
		v_code_abbreviation				IN VARCHAR2 := NULL,
		v_station_code					IN VARCHAR2 := NULL,
		v_ethnic_group					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_order_hl7_pacs
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_id_issuer_code		IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_race_code						IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_account_no					IN VARCHAR2,
		v_address						IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,
		v_access_no						IN VARCHAR2,
		v_order_stat					IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_comments				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,
		v_order_entry_location			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_id					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,
		v_reqproc_code_meaning			IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_reqproc_comments				IN VARCHAR2,
		v_reqproc_priority				IN VARCHAR2,
		v_reqproc_location				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_diagnosis_code				IN VARCHAR2 := NULL,
		v_diagnosis_code_meaning		IN VARCHAR2 := NULL,
		v_note_and_comments				IN VARCHAR2 := NULL,
		v_vet_sex_neutered		IN VARCHAR2 := NULL,
		v_species_code_description	IN VARCHAR2 := NULL,
		v_breed_code_description	IN VARCHAR2 := NULL,
		v_nk1_name		IN VARCHAR2 := NULL,
		v_nk1_relationship		IN VARCHAR2 := NULL,
		v_nk1_organization_name		IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_hl7_pacs
	(
		v_study_key						IN NUMBER,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_ex_hl7_pacs
	(
		v_study_key						IN NUMBER,
		v_procplan_key					IN NUMBER,
		v_station_key					IN NUMBER,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_report_hl7_pacs
	(
		v_event_type						IN VARCHAR2,
		v_report_control_id					IN VARCHAR2,
		v_accession_no						IN VARCHAR2,
		v_patient_id						IN VARCHAR2,
		v_report_stat						IN VARCHAR2,
		v_creator_id						IN VARCHAR2,
		v_creator_name						IN VARCHAR2,
		v_create_dttm						IN VARCHAR2,
		v_dictator_id						IN VARCHAR2,
		v_dictator_name						IN VARCHAR2,
		v_dictate_dttm						IN VARCHAR2,
		v_transcriber_id					IN VARCHAR2,
		v_transcriber_name					IN VARCHAR2,
		v_transcribe_dttm					IN VARCHAR2,
		v_approver_id						IN VARCHAR2,
		v_approver_name						IN VARCHAR2,
		v_approve_dttm						IN VARCHAR2,
		v_reviser_id						IN VARCHAR2,
		v_reviser_name						IN VARCHAR2,
		v_revise_dttm						IN VARCHAR2,
		v_report_type						IN VARCHAR2,
		v_IsFirstReport						IN VARCHAR2,
		v_report_text						IN LONG,
		v_conclusion						IN LONG,
		v_put_report_type					IN VARCHAR2
	)
	RETURN NUMBER;
-------------------------------------------------------------------------------------------------
-- processing for HL7 (IHE)
-------------------------------------------------------------------------------------------------
	FUNCTION put_patient_hl7_ihe
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_prior_patient_id				IN VARCHAR2 := NULL,
		v_patient_id_issuer_code		IN VARCHAR2 := NULL,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2 := NULL,
		v_first_name					IN VARCHAR2 := NULL,
		v_middle_name					IN VARCHAR2 := NULL,
		v_prefix						IN VARCHAR2 := NULL,
		v_suffix						IN VARCHAR2 := NULL,
		v_marital_stat					IN VARCHAR2 := NULL,
		v_confidentiality				IN VARCHAR2 := NULL,
		v_patient_birth_dttm			IN VARCHAR2 := NULL,
		v_patient_death_dttm			IN VARCHAR2 := NULL,
		v_patient_sex					IN VARCHAR2 := NULL,
		v_patient_size					IN VARCHAR2 := NULL,
		v_patient_weight				IN VARCHAR2 := NULL,
		v_blood_type_abo				IN VARCHAR2 := NULL,
		v_blood_type_rh					IN VARCHAR2 := NULL,
		v_citizenship					IN VARCHAR2 := NULL,
		v_occupation					IN VARCHAR2 := NULL,
		v_race_code						IN VARCHAR2 := NULL,
		v_language_code					IN VARCHAR2 := NULL,
		v_religion_code					IN VARCHAR2 := NULL,
		v_birthplace					IN VARCHAR2 := NULL,
		v_multiple_birth_status			IN VARCHAR2 := NULL,
		v_birth_order					IN VARCHAR2 := NULL,
		v_email							IN VARCHAR2 := NULL,
		v_phone_no						IN VARCHAR2 := NULL,
		v_pregnancy_code				IN VARCHAR2 := NULL,
		v_patient_stat					IN VARCHAR2 := NULL,
		v_account_no					IN VARCHAR2 := NULL,
		v_contact_type					IN VARCHAR2 := NULL,
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL,
		v_fax_no						IN VARCHAR2 := NULL,
		v_address						IN VARCHAR2 := NULL,
		v_city							IN VARCHAR2 := NULL,
		v_state							IN VARCHAR2 := NULL,
		v_country						IN VARCHAR2 := NULL,
		v_zipcode						IN VARCHAR2 := NULL,
		v_visit_number					IN VARCHAR2,
		v_visit_stat					IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2 := NULL,
		v_discharge_dttm				IN VARCHAR2 := NULL,
		v_patient_location				IN VARCHAR2 := NULL,
		v_patient_residence				IN VARCHAR2 := NULL,
		v_refer_doctor_id				IN VARCHAR2 := NULL,
		v_consult_doctor_id				IN VARCHAR2 := NULL,
		v_institution_code				IN VARCHAR2 := NULL,
		v_visit_comment					IN VARCHAR2 := NULL,
		v_admit_route					IN VARCHAR2 := NULL,
		v_lastmen_strual_dttm			IN VARCHAR2 := NULL,
		v_pregnancy_status				IN VARCHAR2 := NULL,
		v_code_abbreviation				IN VARCHAR2 := NULL,
		v_station_code					IN VARCHAR2 := NULL,
		v_ethnic_group					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_order_hl7_ihe
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_id_issuer_code		IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_race_code						IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_account_no					IN VARCHAR2,
		v_address						IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,
		v_access_no						IN VARCHAR2,
		v_order_stat					IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_comments				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,
		v_order_entry_location			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_id					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,
		v_reqproc_code_meaning			IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_reqproc_comments				IN VARCHAR2,
		v_reqproc_priority				IN VARCHAR2,
		v_reqproc_location				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_diagnosis_code				IN VARCHAR2 := NULL,
		v_diagnosis_code_meaning		IN VARCHAR2 := NULL,
		v_note_and_comments				IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_hl7_ihe
	(
		v_study_key						IN NUMBER,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_ex_hl7_ihe
	(
		v_study_key						IN NUMBER,
		v_procplan_key					IN NUMBER,
		v_station_key					IN NUMBER,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_report_hl7_ihe
	(
		v_event_type						IN VARCHAR2,
		v_report_control_id					IN VARCHAR2,
		v_accession_no						IN VARCHAR2,
		v_patient_id						IN VARCHAR2,
		v_report_stat						IN VARCHAR2,
		v_creator_id						IN VARCHAR2,
		v_creator_name						IN VARCHAR2,
		v_create_dttm						IN VARCHAR2,
		v_dictator_id						IN VARCHAR2,
		v_dictator_name						IN VARCHAR2,
		v_dictate_dttm						IN VARCHAR2,
		v_transcriber_id					IN VARCHAR2,
		v_transcriber_name					IN VARCHAR2,
		v_transcribe_dttm					IN VARCHAR2,
		v_approver_id						IN VARCHAR2,
		v_approver_name						IN VARCHAR2,
		v_approve_dttm						IN VARCHAR2,
		v_reviser_id						IN VARCHAR2,
		v_reviser_name						IN VARCHAR2,
		v_revise_dttm						IN VARCHAR2,
		v_report_type						IN VARCHAR2,
		v_IsFirstReport						IN VARCHAR2,
		v_report_text						IN LONG,
		v_conclusion						IN LONG,
		v_put_report_type					IN VARCHAR2
		
	)
	RETURN NUMBER;
-------------------------------------------------------------------------------------------------
-- processing for ODBC
-------------------------------------------------------------------------------------------------
	FUNCTION put_patient_odbc
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_prior_patient_id				IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_english_name					IN VARCHAR2,
		v_patient_ssn					IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_patient_weight				IN VARCHAR2,
		v_patient_size					IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,
		v_tel_no						IN VARCHAR2,
		v_fax_no						IN VARCHAR2,
		v_zipcode						IN VARCHAR2,
		v_address						IN VARCHAR2,
		v_email							IN VARCHAR2,
		v_blood_type					IN VARCHAR2,
		v_pregnancy_status				IN VARCHAR2,
		v_current_location				IN VARCHAR2,
		v_current_residency				IN VARCHAR2,
		v_current_department			IN VARCHAR2,
		v_current_doctor_id				IN VARCHAR2,
		v_current_doctor_name			IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_broker_aetitle				IN VARCHAR2
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_order_odbc
	(
		v_event_type					IN VARCHAR2,
		v_order_control_id				IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_id_issuer_code		IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_middle_name					IN VARCHAR2,
		v_prefix						IN VARCHAR2,
		v_suffix						IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_race_code						IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_account_no					IN VARCHAR2,
		v_address						IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_placer_order_id				IN VARCHAR2,
		v_filler_order_id				IN VARCHAR2,
		v_access_no						IN VARCHAR2,
		v_order_stat					IN VARCHAR2,
		v_order_reason					IN VARCHAR2,
		v_order_comments				IN VARCHAR2,
		v_order_dttm					IN VARCHAR2,
		v_order_doctor_id				IN VARCHAR2,
		v_order_department				IN VARCHAR2,
		v_order_entry_user_id			IN VARCHAR2,
		v_order_entry_location			IN VARCHAR2,
		v_order_callback_phone_no		IN VARCHAR2,
		v_attend_doctor_id				IN VARCHAR2,
		v_perform_doctor_id				IN VARCHAR2,
		v_reqproc_stat					IN VARCHAR2,
		v_reqproc_id					IN VARCHAR2,
		v_reqproc_desc					IN VARCHAR2,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_reqproc_code_version			IN VARCHAR2,
		v_reqproc_code_meaning			IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_reqproc_reason				IN VARCHAR2,
		v_reqproc_comments				IN VARCHAR2,
		v_reqproc_priority				IN VARCHAR2,
		v_reqproc_location				IN VARCHAR2,
		v_patient_arrange				IN VARCHAR2,
		v_diagnosis						IN VARCHAR2,
		v_other_patient_id				IN VARCHAR2,
		v_other_patient_name			IN VARCHAR2,
		v_source_aetitle				IN VARCHAR2,
		v_broker_aetitle				IN VARCHAR2,
		v_patient_ssn					IN VARCHAR2 := NULL,
		v_patient_weight          		IN VARCHAR2 := NULL,
		v_patient_size          		IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_odbc
	(
		v_study_key						IN NUMBER,
		v_reqproc_code_value			IN VARCHAR2,
		v_reqproc_code_scheme			IN VARCHAR2,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER,
		v_aetitle						IN VARCHAR2,
		v_scheduled_location			IN VARCHAR2
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_msps_ex_odbc
	(
		v_study_key						IN NUMBER,
		v_procplan_key					IN NUMBER,
		v_station_key					IN NUMBER,
		v_sps_id						IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_sps_start_dttm				IN VARCHAR2,
		v_protcode_value				IN VARCHAR2,
		v_protcode_scheme				IN VARCHAR2,
		v_protcode_meaning				IN VARCHAR2,
		v_index							IN NUMBER
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_report_odbc
	(
		v_accession_no						IN VARCHAR2,
		v_patient_id						IN VARCHAR2,
		v_report_stat						IN VARCHAR2,
		v_creator_id						IN VARCHAR2,
		v_creator_name						IN VARCHAR2,
		v_create_dttm						IN VARCHAR2,
		v_dictator_id						IN VARCHAR2,
		v_dictator_name						IN VARCHAR2,
		v_dictate_dttm						IN VARCHAR2,
		v_transcriber_id					IN VARCHAR2,
		v_transcriber_name					IN VARCHAR2,
		v_transcribe_dttm					IN VARCHAR2,
		v_approver_id						IN VARCHAR2,
		v_approver_name						IN VARCHAR2,
		v_approve_dttm						IN VARCHAR2,
		v_reviser_id						IN VARCHAR2,
		v_reviser_name						IN VARCHAR2,
		v_revise_dttm						IN VARCHAR2,
		v_report_type						IN VARCHAR2,
		v_IsFirstReport		IN VARCHAR2,
		v_report_text						IN LONG,		
		v_conclusion						IN LONG
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------
	PROCEDURE mwl_put
	(
		v_character_set					IN VARCHAR2,
		v_scheduled_aetitle				IN VARCHAR2,
		v_scheduled_dttm				IN VARCHAR2,
		v_scheduled_modality			IN VARCHAR2,
		v_scheduled_station				IN VARCHAR2,
		v_scheduled_location			IN VARCHAR2,
		v_scheduled_proc_id				IN VARCHAR2,
		v_scheduled_proc_desc			IN VARCHAR2,
		v_scheduled_action_codes		IN VARCHAR2,
		v_scheduled_proc_status			IN VARCHAR2,
		v_premedication					IN VARCHAR2,
		v_contrast_agent				IN VARCHAR2,
		v_requested_proc_id				IN VARCHAR2,
		v_requested_proc_desc			IN VARCHAR2,
		v_requested_proc_codes			IN VARCHAR2,
		v_requested_proc_priority		IN VARCHAR2,
		v_requested_proc_reason			IN VARCHAR2,
		v_requested_proc_comments		IN VARCHAR2,
		v_study_instance_uid			IN VARCHAR2,
		v_proc_placer_order_no			IN VARCHAR2,
		v_proc_filler_order_no			IN VARCHAR2,
		v_accession_no					IN VARCHAR2,
		v_attend_doctor					IN VARCHAR2,
		v_perform_doctor				IN VARCHAR2,
		v_consult_doctor				IN VARCHAR2,
		v_request_doctor				IN VARCHAR2,
		v_refer_doctor					IN VARCHAR2,
		v_request_department			IN VARCHAR2,
		v_imaging_request_reason		IN VARCHAR2,
		v_imaging_request_comments		IN VARCHAR2,
		v_imaging_request_dttm			IN VARCHAR2,
		v_isr_placer_order_no			IN VARCHAR2,
		v_isr_filler_order_no			IN VARCHAR2,
		v_admission_id					IN VARCHAR2,
		v_patient_transport				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residency				IN VARCHAR2,
		v_patient_name					IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_other_patient_name			IN VARCHAR2,
		v_other_patient_id				IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_sex					IN VARCHAR2,
		v_patient_weight				IN VARCHAR2,
		v_patient_size					IN VARCHAR2,
		v_patient_state					IN VARCHAR2,
		v_confidentiality				IN VARCHAR2,
		v_pregnancy_status				IN VARCHAR2,
		v_medical_alerts				IN VARCHAR2,
		v_contrast_allergies			IN VARCHAR2,
		v_special_needs					IN VARCHAR2,
		v_specialty						IN VARCHAR2,
		v_diagnosis						IN VARCHAR2,
		v_admit_dttm					IN VARCHAR2,
		v_register_dttm					IN VARCHAR2,
		v_study_ssn						IN VARCHAR2
	);
	-------------------------------------------------------------------------------------------
	PROCEDURE orm_put
	(
		v_order_control_id			IN	VARCHAR2,
		v_character_set				IN	mwl.character_set%TYPE,				
		v_scheduled_aetitle			IN	mwl.scheduled_aetitle%TYPE,			
		v_scheduled_dttm			IN	mwl.scheduled_dttm%TYPE,			
		v_scheduled_modality		IN	mwl.scheduled_modality%TYPE,		
		v_scheduled_station			IN	mwl.scheduled_station%TYPE,			
		v_scheduled_location		IN	mwl.scheduled_location%TYPE,		
		v_scheduled_proc_id			IN	mwl.scheduled_proc_id%TYPE,			
		v_scheduled_proc_desc		IN	mwl.scheduled_proc_desc%TYPE,		
		v_scheduled_action_codes	IN	mwl.scheduled_action_codes%TYPE,	
		v_scheduled_proc_status		IN	mwl.scheduled_proc_status%TYPE,		
		v_premedication				IN	mwl.premedication%TYPE,		
		v_contrast_agent			IN	mwl.contrast_agent%TYPE,			
		v_requested_proc_id			IN	mwl.requested_proc_id%TYPE,			
		v_requested_proc_desc		IN	mwl.requested_proc_desc%TYPE,		
		v_requested_proc_codes		IN	mwl.requested_proc_codes%TYPE,		
		v_requested_proc_priority	IN	mwl.requested_proc_priority%TYPE,	
		v_requested_proc_reason		IN	mwl.requested_proc_reason%TYPE,		
		v_requested_proc_comments	IN	mwl.requested_proc_comments%TYPE,	
		v_study_instance_uid		IN	mwl.study_instance_uid%TYPE,		
		v_proc_placer_order_no		IN	mwl.proc_placer_order_no%TYPE,		
		v_proc_filler_order_no		IN	mwl.proc_filler_order_no%TYPE,		
		v_accession_no				IN	mwl.accession_no%TYPE,				
		v_attend_doctor				IN	mwl.attend_doctor%TYPE,				
		v_perform_doctor			IN	mwl.perform_doctor%TYPE,			
		v_consult_doctor			IN	mwl.consult_doctor%TYPE,			
		v_request_doctor			IN	mwl.request_doctor%TYPE,			
		v_refer_doctor				IN	mwl.refer_doctor%TYPE,				
		v_request_department		IN	mwl.request_department%TYPE,		
		v_imaging_request_reason	IN	mwl.imaging_request_reason%TYPE,	
		v_imaging_request_comments	IN	mwl.imaging_request_comments%TYPE,	
		v_imaging_request_dttm		IN	mwl.imaging_request_dttm%TYPE,		
		v_isr_placer_order_no		IN	mwl.isr_placer_order_no%TYPE,		
		v_isr_filler_order_no		IN	mwl.isr_filler_order_no%TYPE,		
		v_admission_id				IN	mwl.admission_id%TYPE,				
		v_patient_transport			IN	mwl.patient_transport%TYPE,			
		v_patient_location			IN	mwl.patient_location%TYPE,			
		v_patient_residency			IN	mwl.patient_residency%TYPE,			
		v_patient_name				IN	mwl.patient_name%TYPE,				
		v_patient_id				IN	mwl.patient_id%TYPE,				
		v_other_patient_name		IN	mwl.other_patient_name%TYPE,		
		v_other_patient_id			IN	mwl.other_patient_id%TYPE,			
		v_patient_birth_dttm		IN	mwl.patient_birth_dttm%TYPE,		
		v_patient_sex				IN	mwl.patient_sex%TYPE,				
		v_patient_weight			IN	mwl.patient_weight%TYPE,			
		v_patient_size				IN	mwl.patient_size%TYPE,				
		v_patient_state				IN	mwl.patient_state%TYPE,				
		v_confidentiality			IN	mwl.confidentiality%TYPE,			
		v_pregnancy_status			IN	mwl.pregnancy_status%TYPE,			
		v_medical_alerts			IN	mwl.medical_alerts%TYPE,			
		v_contrast_allergies		IN	mwl.contrast_allergies%TYPE,		
		v_special_needs				IN	mwl.special_needs%TYPE,			
		v_specialty					IN	mwl.specialty%TYPE,					
		v_diagnosis					IN	mwl.diagnosis%TYPE,
		v_admit_dttm				IN	mwl.admit_dttm%TYPE,
		v_register_dttm				IN	mwl.register_dttm%TYPE,
		v_study_ssn					IN	mwl.study_ssn%TYPE
	);
-------------------------------------------------------------------------------------------------
-- Sub Function for ADT of ODBC, HL7 (put_patient)
-------------------------------------------------------------------------------------------------
	FUNCTION adt_a01
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,							--10
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,							--20
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,					--30
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION adt_a02
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency	 			IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a03
	(
		v_patient_id		 			IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency	 			IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a03
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a04
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION adt_a06
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency				IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION adt_a07
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location	 			IN visit.patient_location%TYPE
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a08
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION adt_a18
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN patient.patient_id%TYPE,
		v_prior_patient_id				IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a28
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a31
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_email							IN patient.email%TYPE,
		v_race_code						IN VARCHAR2,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
	-- patientcontact	
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
	-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2,
		v_ethnic_group					IN VARCHAR2,									--40
		v_home_phone_no					IN VARCHAR2 := NULL,
		v_busi_phone_no					IN VARCHAR2 := NULL
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a40
	(
		v_event_type					IN VARCHAR2,
	-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_prior_patient_id				IN patient.patient_id%TYPE,
		v_patient_id_issuer				IN patient.patient_id_issuer%TYPE
	)
	RETURN patient.patient_key%TYPE;
-------------------------------------------------------------------------------------------------
-- Sub Function for ADT of HL7 (put_patient_ex)
-------------------------------------------------------------------------------------------------
	FUNCTION adt_a01_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a02_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a03_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a04_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a06_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a07_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a08_ex
	(
		v_event_type					IN VARCHAR2,
		-- patient
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_ssn					IN patient.patient_ssn%TYPE,
		v_patient_name					IN patient.patient_name%TYPE,
		v_last_name						IN patient.last_name%TYPE,
		v_first_name					IN patient.first_name%TYPE,
		v_middle_name					IN patient.middle_name%TYPE,
		v_prefix						IN patient.prefix%TYPE,
		v_suffix						IN patient.suffix%TYPE,
		v_marital_stat					IN patient.marital_stat%TYPE,
		v_confidentiality				IN patient.confidentiality%TYPE,
		v_patient_birth_dttm			IN VARCHAR2,
		v_patient_death_dttm			IN VARCHAR2,
		v_patient_sex					IN patient.patient_sex%TYPE,
		v_patient_size					IN patient.patient_size%TYPE,
		v_patient_weight				IN patient.patient_weight%TYPE,
		v_blood_type_abo				IN patient.blood_type_abo%TYPE,
		v_blood_type_rh					IN patient.blood_type_rh%TYPE,
		v_race_code						IN VARCHAR2,
		v_email							IN patient.email%TYPE,
		v_phone_no						IN patient.phone_no%TYPE,
		v_patient_stat					IN patient.patient_stat%TYPE,
		v_account_no					IN patient.account_no%TYPE,
		-- patientcontact
		v_contact_type					IN patientcontact.contact_type%TYPE,
		v_fax_no						IN patientcontact.fax_no%TYPE,
		v_address						IN patientcontact.address%TYPE,
		v_city							IN patientcontact.city%TYPE,
		v_state							IN patientcontact.state%TYPE,
		v_country						IN patientcontact.country%TYPE,
		v_zipcode						IN patientcontact.zipcode%TYPE,
		-- visit
		v_visit_number					IN visit.visit_no%TYPE,
		v_visit_stat					IN visit.visit_stat%TYPE,
		v_admit_dttm					IN VARCHAR2,
		v_discharge_dttm				IN VARCHAR2,
		v_patient_location				IN VARCHAR2,
		v_patient_residence				IN VARCHAR2,
		v_refer_doctor_id				IN VARCHAR2,
		v_consult_doctor_id				IN VARCHAR2
	)
	RETURN patient.patient_key%TYPE;
-------------------------------------------------------------------------------------------------
-- additional procedure
-------------------------------------------------------------------------------------------------
	PROCEDURE remove_study
	(
		v_study_key						IN study.study_key%TYPE,
		v_remover_key					IN users.user_key%TYPE,
		v_force							IN BOOLEAN := FALSE
	);
	-------------------------------------------------------------------------------------------------
	PROCEDURE Study_modify
	(
		v_study_key						IN study.study_key%TYPE,
		v_procplan_key					IN study.procplan_key%TYPE,
		v_study_reason					IN study.study_reason%TYPE,
		v_study_comments				IN study.study_comments%TYPE,
		v_study_priority				IN study.study_priority%TYPE,
		v_patient_arrange				IN study.patient_arrange%TYPE,
		v_access_no						IN study.access_no%TYPE,
		v_other_patient_id				IN study.other_patient_id%TYPE,
		v_other_patient_name			IN study.other_patient_name%TYPE
	);
	-------------------------------------------------------------------------------------------------
	PROCEDURE Iorder_modify
	(
		v_order_key						IN iorder.order_key%TYPE,
		v_patient_key					IN iorder.patient_key%TYPE,
		v_visit_key						IN iorder.visit_key%TYPE,
		v_placer_order_id				IN iorder.placer_order_id%TYPE,
		v_order_reason					IN iorder.order_reason%TYPE,
		v_order_comments				IN iorder.order_comments%TYPE,
		v_order_doctor_key				IN iorder.order_doctor_key%TYPE,
		v_refer_doctor_key				IN iorder.refer_doctor_key%TYPE,
		v_order_department_code			IN iorder.order_department_code%TYPE,
		v_order_entry_user_key			IN iorder.order_entry_user_key%TYPE,
		v_order_entry_location			IN iorder.order_entry_location%TYPE,
		v_order_callback_phone_no		IN iorder.order_callback_phone_no%TYPE,
		v_patinsu1_key					IN iorder.patinsu1_key%TYPE := NULL,
		v_patinsu2_key					IN iorder.patinsu2_key%TYPE := NULL,
		v_order_dttm					IN iorder.order_dttm%TYPE
	);
	-------------------------------------------------------------------------------------------------
	PROCEDURE update_doctor
	(
		v_study_key						IN study.study_key%TYPE,
		v_refer_doctor_key				IN NUMBER := NULL,
		v_request_doctor_key			IN NUMBER := NULL,
		v_consult_doctor_key			IN NUMBER := NULL,
		v_attend_doctor_key				IN NUMBER := NULL,
		v_perform_doctor_key			IN NUMBER := NULL,
		v_study_reason					IN study.study_reason%TYPE := NULL
	);
	-------------------------------------------------------------------------------------------------
	PROCEDURE user_modify
	(
		v_study_key						IN study.study_key%TYPE,
		v_refer_doctor_key				IN NUMBER := NULL,
		v_request_doctor_key			IN NUMBER := NULL,
		v_study_reason					IN study.study_reason%TYPE := NULL
	);
	-------------------------------------------------------------------------------------------------
	PROCEDURE put_department_unmatched
	(
		v_department_code				IN VARCHAR2,
		v_department_name				IN VARCHAR2
	);
-------------------------------------------------------------------------------------------------
-- additional function
-------------------------------------------------------------------------------------------------
	FUNCTION Study_addnew
	(
		v_order_key						IN study.order_key%TYPE,
		v_procplan_key					IN study.procplan_key%TYPE,
		v_study_reason					IN study.study_reason%TYPE,
		v_study_comments				IN study.study_comments%TYPE,
		v_study_priority				IN study.study_priority%TYPE,
		v_patient_arrange				IN study.patient_arrange%TYPE,
		v_patient_location				IN study.patient_location%TYPE := NULL,
		v_access_no						IN study.access_no%TYPE := NULL,
		v_study_instance_uid			IN study.study_instance_uid%TYPE := NULL,
		v_other_patient_name			IN study.other_patient_name%TYPE
	)
	RETURN study.study_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_procplan_unmatched
	(
		v_code_value					IN VARCHAR2,
		v_code_scheme					IN VARCHAR2,
		v_code_version					IN VARCHAR2,
		v_code_meaning					IN VARCHAR2
	)
	RETURN procplan.procplan_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_procplan_unmatched
	(
		v_code_value					IN VARCHAR2,
		v_code_scheme					IN VARCHAR2,
		v_code_version					IN VARCHAR2,
		v_code_meaning	 				IN VARCHAR2,
		v_reqproc_desc	 				IN VARCHAR2
	)
	RETURN procplan.procplan_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_password						IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_station_unmatched
	(
		v_modality_code					IN VARCHAR2,
		v_source_aetitle				IN VARCHAR2,
		v_institution_code				IN VARCHAR2 := NULL
	)
	RETURN station.station_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_order_key
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.order_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_key_acn
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_protocol_key
	(
		v_reqproc_code_value			IN VARCHAR2,
		v_modality						IN VARCHAR2
	)
	RETURN protocol.protocol_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_institution_code
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_institution_code
	(
		v_idissuer_code					IN VARCHAR2
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_issuer_code
	(
		v_aetitle						IN station.aetitle%TYPE
	)
	RETURN idissuer.issuer_code%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_issuer_code
	(
		v_institution_code				IN idissuer.institution_code%TYPE
	)
	RETURN idissuer.issuer_code%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION get_sps_end_dttm
	(
		v_sps_start_dttm				IN msps.sps_start_dttm%TYPE,
		v_protocol_key					IN protocol.protocol_key%TYPE
	)
	RETURN msps.sps_end_dttm%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_station_key_by_modality
	(
		v_modality						IN VARCHAR2
	)
	RETURN stationmod.station_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_patientcontact_key
	(
		v_patient_key					IN patientcontact.patient_key%TYPE,
		v_contact_type					IN patientcontact.contact_type%TYPE
	)
	RETURN patientcontact.patientcontact_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION parse_count
	(
		v_string					IN VARCHAR2,
		v_separator					IN CHAR
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------
	FUNCTION insert_newline
	(
		v_text							IN VARCHAR2,
		v_seperator						IN VARCHAR2
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_study_key_for_report
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE;

	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_study_key_for_report_2	-- for INA
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_usercontact_key
	(
		v_user_key						IN usercontact.user_key%TYPE,
		v_contact_type					IN usercontact.contact_type%TYPE
	)
	RETURN usercontact.usercontact_key%TYPE;
	------------------------------------------------------------------------------------------------
	FUNCTION xpatient_lookup_key
	(
		v_vendor						IN xpatient.vendor%TYPE,
		v_vendor_pat_id					IN xpatient.vendor_pat_id%TYPE
	)RETURN xpatient.xpatient_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION xphysician_lookup_key
	(
		v_vendor						IN xphysician.vendor%TYPE,
		v_vendor_phy_id					IN xphysician.vendor_phy_id%TYPE
	)RETURN xphysician.xphysician_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION xprocedure_lookup_key
	(
		v_vendor						IN xprocedure.vendor%TYPE,
		v_vendor_proc_code				IN xprocedure.vendor_proc_code%TYPE
	)RETURN xprocedure.xprocedure_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION xorm_lookup_key
	(
		v_vendor						IN xorm.vendor%TYPE,
		v_vendor_pat_id					IN xorm.vendor_pat_id%TYPE,
		v_vendor_phy_id					IN xorm.vendor_phy_id%TYPE,
		v_vendor_proc_code				IN xorm.vendor_proc_code%TYPE
	)RETURN xorm.xorm_key%TYPE;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_report_text
	(
		v_report_key					IN NUMBER
	)
	RETURN clob;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_study_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_series_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_sop_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_hl7history
	(
		v_interface_type			 	IN hl7history.interface_type%TYPE,
		v_message_type					IN hl7history.message_type%TYPE,
		v_event_type					IN hl7history.status%TYPE,
		v_status						IN hl7history.patient_id%TYPE,
		v_patient_id					IN hl7history.patient_name%TYPE,
		v_patient_name					IN hl7history.access_no%TYPE,
		v_access_no						IN hl7history.patient_name%TYPE,
		v_processing_id					IN hl7history.processing_id%TYPE,
		v_reason_of_fail				IN hl7history.reason_of_fail%TYPE,
		v_hl7message					IN hl7history.hl7message%TYPE,  
		v_over4Kbyte					IN VARCHAR2,
		v_pre_history_key				IN hl7history.history_key%TYPE
	)
	RETURN hl7history.history_key%TYPE;                                                                          
	-------------------------------------------------------------------------------------------------	
	FUNCTION put_xmlinfo
	(
		v_xmlinfo_value01					IN VARCHAR2,
		v_xmlinfo_value02					IN VARCHAR2,
		v_xmlinfo_value03					IN VARCHAR2,
		v_xmlinfo_value04					IN VARCHAR2,
		v_xmlinfo_value05					IN VARCHAR2,
		v_xmlinfo_value06					IN VARCHAR2,
		v_xmlinfo_value07					IN VARCHAR2,
		v_xmlinfo_value08					IN VARCHAR2,
		v_xmlinfo_value09					IN VARCHAR2,
		v_xmlinfo_value10					IN VARCHAR2,
		v_xmlinfo_value11					IN VARCHAR2,
		v_xmlinfo_value12					IN VARCHAR2,
		v_xmlinfo_value13					IN VARCHAR2,		
		v_xmlinfo_value14					IN VARCHAR2,
		v_xmlinfo_value15					IN VARCHAR2,
		v_xmlinfo_value16					IN VARCHAR2,
		v_xmlinfo_value17					IN VARCHAR2,
		v_xmlinfo_value18					IN VARCHAR2,
		v_xmlinfo_value19					IN VARCHAR2,
		v_xmlinfo_value20					IN VARCHAR2,
		v_xmlinfo_value21					IN VARCHAR2,
		v_xmlinfo_value22					IN VARCHAR2,
		v_xmlinfo_value23					IN VARCHAR2,
		v_xmlinfo_value24					IN VARCHAR2,
		v_xmlinfo_value25					IN VARCHAR2, 
		v_xmlinfo_value26					IN VARCHAR2,
		v_xmlinfo_value27					IN VARCHAR2,
		v_xmlinfo_value28					IN VARCHAR2,
		v_xmlinfo_value29					IN VARCHAR2,
		v_xmlinfo_value30					IN VARCHAR2,
		v_xmlinfo_value31					IN VARCHAR2,
		v_xmlinfo_value32					IN VARCHAR2,
		v_xmlinfo_value33					IN VARCHAR2,
		v_xmlinfo_value34					IN VARCHAR2,
		v_xmlinfo_value35					IN VARCHAR2,
		v_xmlinfo_value36					IN VARCHAR2,
		v_xmlinfo_value37					IN VARCHAR2,
		v_xmlinfo_value38					IN VARCHAR2,
		v_xmlinfo_value39					IN VARCHAR2,
		v_xmlinfo_value40					IN VARCHAR2,
		v_xmlinfo_value41					IN VARCHAR2,
		v_xmlinfo_value42					IN VARCHAR2,
		v_xmlinfo_value43					IN VARCHAR2,
		v_xmlinfo_value44					IN VARCHAR2,
		v_xmlinfo_value45					IN VARCHAR2,
		v_xmlinfo_value46					IN VARCHAR2,
		v_xmlinfo_value47					IN VARCHAR2,
		v_xmlinfo_value48					IN VARCHAR2,
		v_xmlinfo_value49					IN VARCHAR2,
		v_xmlinfo_value50					IN VARCHAR2,
		v_xmlinfo_value51					IN VARCHAR2,
		v_xmlinfo_value52					IN VARCHAR2,
		v_xmlinfo_value53					IN VARCHAR2,
		v_xmlinfo_value54					IN VARCHAR2,
		v_xmlinfo_value55					IN VARCHAR2,
		v_xmlinfo_value56					IN VARCHAR2,
		v_xmlinfo_value57					IN VARCHAR2,
		v_xmlinfo_value58					IN VARCHAR2,
		v_xmlinfo_value59					IN VARCHAR2,
		v_xmlinfo_value60					IN VARCHAR2,
		v_xmlinfo_value61					IN VARCHAR2,
		v_broker_type				 		IN VARCHAR2,
		v_message_type						IN VARCHAR2
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------	
	FUNCTION put_JsonInfo
	(
		v_JsonInfo_value01					IN VARCHAR2,
		v_JsonInfo_value02					IN VARCHAR2,
		v_JsonInfo_value03					IN VARCHAR2,
		v_JsonInfo_value04					IN VARCHAR2,
		v_JsonInfo_value05					IN VARCHAR2,
		v_JsonInfo_value06					IN VARCHAR2,
		v_JsonInfo_value07					IN VARCHAR2,
		v_JsonInfo_value08					IN VARCHAR2,
		v_JsonInfo_value09					IN VARCHAR2,
		v_JsonInfo_value10					IN VARCHAR2,
		v_JsonInfo_value11					IN VARCHAR2,
		v_JsonInfo_value12					IN VARCHAR2,
		v_JsonInfo_value13					IN VARCHAR2,		
		v_JsonInfo_value14					IN VARCHAR2,
		v_JsonInfo_value15					IN VARCHAR2,
		v_JsonInfo_value16					IN VARCHAR2,
		v_JsonInfo_value17					IN VARCHAR2,
		v_JsonInfo_value18					IN VARCHAR2,
		v_JsonInfo_value19					IN VARCHAR2,
		v_JsonInfo_value20					IN VARCHAR2,
		v_JsonInfo_value21					IN VARCHAR2,
		v_JsonInfo_value22					IN VARCHAR2,
		v_JsonInfo_value23					IN VARCHAR2,
		v_JsonInfo_value24					IN VARCHAR2,
		v_JsonInfo_value25					IN VARCHAR2, 
		v_JsonInfo_value26					IN VARCHAR2,
		v_JsonInfo_value27					IN VARCHAR2,
		v_JsonInfo_value28					IN VARCHAR2,
		v_JsonInfo_value29					IN VARCHAR2,
		v_JsonInfo_value30					IN VARCHAR2,
		v_JsonInfo_value31					IN VARCHAR2,
		v_JsonInfo_value32					IN VARCHAR2,
		v_JsonInfo_value33					IN VARCHAR2,
		v_JsonInfo_value34					IN VARCHAR2,
		v_JsonInfo_value35					IN VARCHAR2,
		v_JsonInfo_value36					IN VARCHAR2,
		v_JsonInfo_value37					IN VARCHAR2,
		v_JsonInfo_value38					IN VARCHAR2,
		v_JsonInfo_value39					IN VARCHAR2,
		v_JsonInfo_value40					IN VARCHAR2,
		v_JsonInfo_value41					IN VARCHAR2,
		v_JsonInfo_value42					IN VARCHAR2,
		v_JsonInfo_value43					IN VARCHAR2,
		v_JsonInfo_value44					IN VARCHAR2,
		v_JsonInfo_value45					IN VARCHAR2,
		v_JsonInfo_value46					IN VARCHAR2,
		v_JsonInfo_value47					IN VARCHAR2,
		v_JsonInfo_value48					IN VARCHAR2,
		v_JsonInfo_value49					IN VARCHAR2,
		v_JsonInfo_value50					IN VARCHAR2,
		v_JsonInfo_value51					IN VARCHAR2,
		v_JsonInfo_value52					IN VARCHAR2,
		v_JsonInfo_value53					IN VARCHAR2,
		v_JsonInfo_value54					IN VARCHAR2,
		v_JsonInfo_value55					IN VARCHAR2,
		v_JsonInfo_value56					IN VARCHAR2,
		v_JsonInfo_value57					IN VARCHAR2,
		v_JsonInfo_value58					IN VARCHAR2,
		v_JsonInfo_value59					IN VARCHAR2,
		v_JsonInfo_value60					IN VARCHAR2,
		v_broker_type				 		IN VARCHAR2,
		v_message_type						IN VARCHAR2
	)
	RETURN NUMBER;
	-------------------------------------------------------------------------------------------------
	/*function encrypt_url(p_in_val IN VARCHAR2)
	RETURN VARCHAR2; 	*/
	-------------------------------------------------------------------------------------------------
	FUNCTION get_report_html
	(
		v_access_no				IN study.access_no%TYPE
	)
	RETURN clob;  
	--------------------------------------------------------------------------------------------------------
	FUNCTION put_encounter
	(        
		v_EventType			IN VARCHAR2,
		v_PatientId 		IN VARCHAR2,
		v_PriorPatientId 	IN VARCHAR2,
		v_PatientIdIssuer	IN VARCHAR2,		
		v_PatientName 		IN VARCHAR2,
		v_OtherPatientId 	IN VARCHAR2,
		v_OtherPatientName 	IN VARCHAR2,
		v_PatientBirthDttm 	IN VARCHAR2,
		v_PatientSex 		IN VARCHAR2,
		v_PatientLocation	IN VARCHAR2,	-- 10
		v_PatientResidency 	IN VARCHAR2,
		v_Department 		IN VARCHAR2,
		v_AttendDoctorId 	IN VARCHAR2,
		v_ReferDoctorId 	IN VARCHAR2,
		v_ConsultDoctorId 	IN VARCHAR2,
		v_VisitNumber 		IN VARCHAR2,
		v_AdmitDttm 		IN VARCHAR2,
		v_DischargeDttm 	IN VARCHAR2
	)
	RETURN NUMBER;		                                                                                    
	-------------------------------------------------------------------------------------------------	
	FUNCTION get_ebiwcodedict
	(
		v_ebiwsection_code 				IN VARCHAR2, 
		v_ebiwcode_value 				IN VARCHAR2		
	)                         
 	RETURN NUMBER;    
	-------------------------------------------------------------------------------------------------	
	FUNCTION lookup_ebiwcodedict
	(
		v_ebiwsection_code 				IN VARCHAR2, 
		v_ebiwcode_value 				IN VARCHAR2		
	)                         
 	RETURN NUMBER; 
   -------------------------------------------------------------------------------------------------       	
	PROCEDURE del_encounter; 		
	------------------------------------------------------------------------------------------------
	FUNCTION put_insurancefee
	(
		v_study_instance_uid			IN VARCHAR2,
		v_patient_id					IN VARCHAR2,
		v_patient_birth_dttm			IN VARCHAR2,
		v_request_dttm					IN VARCHAR2,
		v_request_code					IN VARCHAR2,
		v_request_name					IN VARCHAR2,
		v_accession_no					IN VARCHAR2,
		v_insurance_code				IN VARCHAR2,
		v_modality						IN VARCHAR2,
		v_emergency						IN VARCHAR2,
		v_special_doctor				IN VARCHAR2
		
	)
	RETURN NUMBER;
	------------------------------------------------------------------------------------------------
	FUNCTION put_document
	(
		v_eventtype                    IN VARCHAR2 := NULL,
		v_processingid                 IN VARCHAR2 := NULL,
		v_patientid                    IN VARCHAR2 := NULL,
		v_patient_id_issuer            IN VARCHAR2 := NULL,
		v_patient_name                 IN VARCHAR2 := NULL, 
		v_last_name                    IN VARCHAR2 := NULL, 
		v_first_name                   IN VARCHAR2 := NULL, 
		v_middle_name                  IN VARCHAR2 := NULL, 
		v_suffix                       IN VARCHAR2 := NULL, 
		v_prefix                       IN VARCHAR2 := NULL,
		v_patient_birth_dttm           IN VARCHAR2 := NULL, 
		v_patient_sex                  IN VARCHAR2 := NULL, 
		v_race_code                    IN VARCHAR2 := NULL, 
		v_account_number               IN VARCHAR2 := NULL, 
		v_patient_ssn                  IN VARCHAR2 := NULL, 
		v_patient_location             IN VARCHAR2 := NULL,
		v_patient_residence            IN VARCHAR2 := NULL, 
		v_refer_doctor_id              IN VARCHAR2 := NULL,
		v_refer_doctor_name            IN VARCHAR2 := NULL, 
		v_consult_doctor_id            IN VARCHAR2 := NULL,
		v_visit_number                 IN VARCHAR2 := NULL,
		v_visit_status                 IN VARCHAR2 := NULL, 
		v_admit_dttm                   IN VARCHAR2 := NULL, 
		v_doc_type                     IN VARCHAR2 := NULL, 
		v_doc_contentpresentation      IN VARCHAR2 := NULL,
		v_activity_dttm                IN VARCHAR2 := NULL,
		v_primary_code_name            IN VARCHAR2 := NULL,
		v_origination_dttm             IN VARCHAR2 := NULL,
		v_transcription_dttm           IN VARCHAR2 := NULL, 
		v_edit_dttm                    IN VARCHAR2 := NULL,
		v_originator_code_name         IN VARCHAR2 := NULL, 
		v_assigneddoc_authenticator    IN VARCHAR2 := NULL, 
		v_transcriptionist_code_name   IN VARCHAR2 := NULL, 
		v_unique_doc_number            IN VARCHAR2 := NULL, 
		v_parent_doc_number            IN VARCHAR2 := NULL, 
		v_placer_order_number          IN VARCHAR2 := NULL,
		v_filler_order_number          IN VARCHAR2 := NULL, 
		v_uniquedoc_file_name          IN VARCHAR2 := NULL,
		v_doc_completion_status        IN VARCHAR2 := NULL, 
		v_doc_confidentiality_status   IN VARCHAR2 := NULL, 
		v_doc_availability_status      IN VARCHAR2 := NULL, 
		v_doc_storage_status           IN VARCHAR2 := NULL, 
		v_doc_change_reason            IN VARCHAR2 := NULL, 
		v_authentication_time_stamp    IN VARCHAR2 := NULL, 
		v_distributed_code_name        IN VARCHAR2 := NULL,
		v_broker_type				   IN VARCHAR2 := NULL
	)
	RETURN NUMBER;
	
	------------------------------------------------------------------------------------------------	
	
	FUNCTION version
	RETURN VARCHAR2;
		PRAGMA RESTRICT_REFERENCES(version, WNDS, WNPS);	
	
	-------------------------------------------------------------------------------------------------
	
	FUNCTION get_AllReports
	(
		p_report_key			 	IN report.report_key%TYPE,
		p_remove_header_yn	IN NUMBER  := 0
	)
	RETURN CLOB;
	
	-------------------------------------------------------------------------------------------------
	FUNCTION create_pdf_convert_queue
	(
		p_pressrouteitem_key			 	IN pressrouteitem.pressrouteitem_key%TYPE
	)
	RETURN NUMBER;
	
	-------------------------------------------------------------------------------------------------
	FUNCTION ReturnPath 
	( 
		v_return_type			IN VARCHAR2,
		v_study_key				IN NUMBER
	)
	RETURN VARCHAR2;
	-------------------------------------------------------------------------------------------------
END;
/
SHOW ERRORS