-------------------------------------------------------------------------------------------------
--	Copyright (c) INFINITT Co., Ltd.
--	All Rights Reserved
-------------------------------------------------------------------------------------------------

CREATE OR REPLACE
PACKAGE BODY sp_mapper
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
	RETURN NUMBER
	IS
		v_patient_key					patient.patient_key%TYPE;
	BEGIN
		IF v_broker_type = 'ODBC' THEN
			v_patient_key := put_patient_odbc
			(
				v_event_type, v_patient_id, v_prior_patient_id, v_patient_name, v_english_name,
				v_patient_ssn, v_patient_birth_dttm, v_patient_sex, v_patient_weight, v_patient_size,
				v_ethnic_group, v_home_phone_no, v_fax_no, v_zipcode, v_address,
				v_email, v_blood_type_abo, v_pregnancy_status, v_patient_location, v_patient_residence,
				v_current_department, v_refer_doctor_id, v_refer_doctor_name, v_admit_dttm, v_discharge_dttm,
				v_broker_aetitle
			);
		ELSIF v_broker_type = 'HL7-PACS' THEN
			v_patient_key := put_patient_hl7_pacs
			(
				v_event_type, v_patient_id, v_prior_patient_id, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality, v_patient_birth_dttm, v_patient_death_dttm,
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				v_citizenship, v_occupation, v_race_code, v_language_code, v_religion_code,
				v_birthplace, v_multiple_birth_status, v_birth_order, v_email, v_phone_no,
				v_pregnancy_code, v_patient_stat, v_account_no, v_contact_type, v_home_phone_no,
				v_busi_phone_no, v_fax_no, v_address, v_city, v_state,
				v_country, v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm,
				v_discharge_dttm, v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id,
				v_institution_code, v_visit_comment, v_admit_route, v_lastmen_strual_dttm, v_pregnancy_status,
				v_code_abbreviation, v_station_code, v_ethnic_group
			);
		ELSIF v_broker_type = 'HL7-IHE' THEN
			v_patient_key := put_patient_hl7_ihe
			(
				v_event_type, v_patient_id, v_prior_patient_id, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality, v_patient_birth_dttm, v_patient_death_dttm,
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				v_citizenship, v_occupation, v_race_code, v_language_code, v_religion_code,
				v_birthplace, v_multiple_birth_status, v_birth_order, v_email, v_phone_no,
				v_pregnancy_code, v_patient_stat, v_account_no, v_contact_type, v_home_phone_no,
				v_busi_phone_no, v_fax_no, v_address, v_city, v_state,
				v_country, v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm,
				v_discharge_dttm, v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id,
				v_institution_code, v_visit_comment, v_admit_route, v_lastmen_strual_dttm, v_pregnancy_status,
				v_code_abbreviation, v_station_code, v_ethnic_group
			);
		ELSE
			raise_application_error (-20001, 'found invalid broker type (type=' || v_broker_type || ')');
		END IF;

		RETURN v_patient_key;
	END;
	
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
		v_patient_size          		IN VARCHAR2 := NULL,
		v_vet_sex_neutered		IN VARCHAR2 := NULL,
		v_species_code_description	IN VARCHAR2 := NULL,
		v_breed_code_description	IN VARCHAR2 := NULL,
		v_nk1_name		IN VARCHAR2 := NULL,
		v_nk1_relationship		IN VARCHAR2 := NULL,
		v_nk1_organization_name		IN VARCHAR2 := NULL
	)
	RETURN NUMBER
	IS
		v_study_key						study.study_key%TYPE;
	BEGIN
		IF v_broker_type = 'ODBC' THEN
			v_study_key := put_order_odbc
				(
					v_event_type, v_order_control_id, v_patient_id, v_patient_id_issuer_code, v_patient_name,
					v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix,
					v_patient_birth_dttm, v_patient_sex, v_race_code, v_confidentiality, v_account_no,
					v_address, v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id,
					v_placer_order_id, v_filler_order_id, v_access_no, v_order_stat, v_order_reason,
					v_order_comments, v_order_dttm, v_order_doctor_id, v_order_department, v_order_entry_user_id,
					v_order_entry_location, v_order_callback_phone_no, v_attend_doctor_id, v_perform_doctor_id, v_reqproc_stat,
					v_reqproc_id, v_reqproc_desc, v_reqproc_code_value, v_reqproc_code_scheme, v_reqproc_code_version,
					v_reqproc_code_meaning, v_study_instance_uid, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_reqproc_location, v_patient_arrange, v_diagnosis, v_other_patient_id, v_other_patient_name,
					v_source_aetitle, v_broker_aetitle, v_patient_ssn, v_patient_weight, v_patient_size
				);
		ELSIF v_broker_type = 'HL7-PACS' THEN
			v_study_key := put_order_hl7_pacs
				(
					v_event_type, v_order_control_id, v_patient_id, v_patient_id_issuer_code, v_patient_name,
					v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix,
					v_patient_birth_dttm, v_patient_sex, v_race_code, v_confidentiality, v_account_no,
					v_address, v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id,
					v_placer_order_id, v_filler_order_id, v_access_no, v_order_stat, v_order_reason,
					v_order_comments, v_order_dttm, v_order_doctor_id, v_order_department, v_order_entry_user_id,
					v_order_entry_location, v_order_callback_phone_no, v_reqproc_stat, v_reqproc_id, v_reqproc_desc,
					v_reqproc_code_value, v_reqproc_code_scheme, v_reqproc_code_version, v_reqproc_code_meaning, v_study_instance_uid,
					v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, v_reqproc_location, v_patient_arrange,
					v_patient_ssn, v_diagnosis_code, v_diagnosis_code_meaning, v_note_and_comments, v_vet_sex_neutered,
					v_species_code_description, v_breed_code_description, v_nk1_name, v_nk1_relationship, v_nk1_organization_name					
				);
		ELSIF v_broker_type = 'HL7-IHE' THEN
			v_study_key := put_order_hl7_ihe
				(
					v_event_type, v_order_control_id, v_patient_id, v_patient_id_issuer_code, v_patient_name,
					v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix,
					v_patient_birth_dttm, v_patient_sex, v_race_code, v_confidentiality, v_account_no,
					v_address, v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id,
					v_placer_order_id, v_filler_order_id, v_access_no, v_order_stat, v_order_reason,
					v_order_comments, v_order_dttm, v_order_doctor_id, v_order_department, v_order_entry_user_id,
					v_order_entry_location, v_order_callback_phone_no, v_reqproc_stat, v_reqproc_id, v_reqproc_desc,
					v_reqproc_code_value, v_reqproc_code_scheme, v_reqproc_code_version, v_reqproc_code_meaning, v_study_instance_uid,
					v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, v_reqproc_location, v_patient_arrange,
					v_patient_ssn, v_diagnosis_code, v_diagnosis_code_meaning, v_note_and_comments
				);
		ELSE
			raise_application_error (-20001, 'found invalid broker type (type=' || v_broker_type || ')');
		END IF;

		RETURN v_study_key;
	END;
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
	RETURN NUMBER
	IS
		v_return_key					NUMBER;
		v_total_xpatient				NUMBER;
		v_total_xphysician				NUMBER;
		v_total_xprocedure				NUMBER;
		v_total_xorm					NUMBER;
	BEGIN
		--xpatient.vendor_id, xphysician.vendor_id, xprocedure.vendor_code, xorm.stat =  search
		--xpatient.vendor_id NOT NULL and xphysician.vendor_id NOT NULL and xprocedure.vendor_code NOT NULL and xorm.stat ='M'
		
		SELECT COUNT(0) INTO v_total_xpatient
			   FROM xpatient
			   WHERE vendor = v_vendor and vendor_pat_id = v_patient_id;				--xpatient
			   
		SELECT COUNT(0) INTO v_total_xphysician
			   FROM xphysician
			   WHERE vendor = v_vendor and vendor_phy_id = v_refer_doctor_id;			--xphysician
			   
		SELECT COUNT(0) INTO v_total_xprocedure
			   FROM xprocedure
			   WHERE vendor = v_vendor and vendor_proc_code = v_reqproc_code_value;		--xprocedure

		
		IF v_total_xpatient >= 1 and v_total_xphysician >= 1 and v_total_xprocedure >= 1 THEN
			RETURN 0;  
		ELSE 
			v_return_key := put_order_crosswalk_ex(v_vendor, v_patient_id, v_patient_name, v_patient_birth_dttm, v_patient_sex, v_patient_ssn, v_refer_doctor_id,
								v_refer_doctor_name, v_reqproc_code_value, v_reqproc_desc, v_hl7_orm_msg, v_order_dttm, v_orm_stat, v_msg_file_name, v_access_no, v_order_control_id);
			IF v_return_key IS NOT NULL THEN
				RETURN v_return_key;
			END IF;
		END IF;
	END;
	-------------------------------------------------------------------------------------------------
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
	) RETURN NUMBER
	IS
		v_xpatient_key				NUMBER;
		v_xphysician_key			NUMBER;	
		v_xprocedure_key 			NUMBER;
		v_xorm_key					NUMBER;
		
	BEGIN
		v_xpatient_key := xpatient_lookup_key(v_vendor, v_vendor_pat_id);
		v_xphysician_key := xphysician_lookup_key(v_vendor, v_vendor_phy_id);
		v_xprocedure_key := xprocedure_lookup_key(v_vendor, v_vendor_proc_code);
		v_xorm_key :=xorm_lookup_key(v_vendor, v_vendor_pat_id, v_vendor_phy_id, v_vendor_proc_code);
		
		IF v_xpatient_key IS NULL THEN
			SELECT sq_xpatient.nextval INTO v_xpatient_key FROM dual;
			INSERT INTO xpatient
			(
				xpatient_key,
				vendor,
				vendor_pat_id,
				patient_name,
				dob,
				sex,
				ssn
			)
			VALUES
			(
				v_xpatient_key,
				v_vendor,
				v_vendor_pat_id,
				v_patient_name,
				sp_util.to_dttm(SUBSTR(v_dob, 1, 8)),
				v_sex,
				v_ssn
			);
			
		ELSE
			UPDATE xpatient
			   SET
				patient_name			= v_patient_name,
				dob						= sp_util.to_dttm(SUBSTR(v_dob, 1, 8)),
				sex						= v_sex,
				ssn						= v_ssn
			WHERE xpatient_key = v_xpatient_key;
		END IF;
		
		IF v_xphysician_key IS NULL THEN
			SELECT sq_xphysician.nextval INTO v_xphysician_key FROM dual;
			INSERT INTO xphysician
			(
				xphysician_key,
				vendor,
				vendor_phy_id,
				physician_name
			)
			VALUES
			(
				v_xphysician_key,
				v_vendor,
				v_vendor_phy_id,
				v_physician_name
			);
			
		ELSE
			UPDATE xphysician
			   SET
				physician_name 				=	v_physician_name
			WHERE xphysician_key = v_xphysician_key;
		END IF;
				
		IF v_xprocedure_key IS NULL THEN
			SELECT sq_xprocedure.nextval INTO v_xprocedure_key FROM dual;
			INSERT INTO xprocedure
			(
				xprocedure_key,
				vendor,
				vendor_proc_code,
				procplan_desc
			)
			VALUES
			(
				v_xprocedure_key,
				v_vendor,
				v_vendor_proc_code,
				v_procplan_desc
			);
			
		ELSE
			UPDATE xprocedure
			   SET
				procplan_desc = v_procplan_desc
			WHERE xprocedure_key = v_xprocedure_key;
		END IF;
		
		IF v_xorm_key IS NULL THEN
		SELECT sq_xorm.nextval INTO v_xorm_key FROM dual;
			INSERT INTO xorm
			(
				xorm_key,
				orm,
				vendor,
				vendor_pat_id,
				vendor_phy_id,
				vendor_proc_code,
				dttm,
				stat,
				filename,
				accession_no,
				message_type
			)
			VALUES
			(
				v_xorm_key,
				v_orm,
				v_vendor,
				v_vendor_pat_id,
				v_vendor_phy_id,
				v_vendor_proc_code,
				sp_util.to_dttm(SUBSTR(v_dttm, 1, 8)),
				v_stat,
				v_msg_file_name,
				v_access_no,
				v_order_control_id
			);
			
		ELSE
			UPDATE xorm
			   SET
				orm							= 	v_orm,
				dttm						=   sp_util.to_dttm(SUBSTR(v_dttm, 1, 8)),
				stat						=   v_stat,
				filename					=   v_msg_file_name,
				accession_no				=   v_access_no,
				message_type				=   v_order_control_id
			WHERE xorm_key = v_xorm_key;
		END IF;
		RETURN v_xorm_key;
	END;
	
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
		v_index							IN NUMBER,					--10
		v_aetitle						IN VARCHAR2	:= NULL,
		v_scheduled_location			IN VARCHAR2	:= NULL,
		v_broker_type					IN VARCHAR2 := NULL,
		v_order_control_id				IN VARCHAR2 := NULL,
		v_order_stat					IN VARCHAR2 := NULL

	)
	RETURN NUMBER
	IS
		v_msps_key						msps.msps_key%TYPE;

	BEGIN
		IF v_broker_type = 'ODBC' THEN
			v_msps_key := put_msps_odbc
			(
				v_study_key, v_reqproc_code_value, v_reqproc_code_scheme, v_sps_id, v_modality,
				v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index,
				v_aetitle, v_scheduled_location
			);
		ELSIF v_broker_type = 'HL7-PACS' THEN
			v_msps_key := put_msps_hl7_pacs
			(
				v_study_key, v_reqproc_code_value, v_reqproc_code_scheme, v_sps_id, v_modality,
				v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index,
				v_order_control_id, v_order_stat
			);
		ELSIF v_broker_type = 'HL7-IHE' THEN
			v_msps_key := put_msps_hl7_ihe
			(
				v_study_key, v_reqproc_code_value, v_reqproc_code_scheme, v_sps_id, v_modality,
				v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index,
				v_order_control_id, v_order_stat
			);
		ELSE
			raise_application_error (-20001, 'found invalid broker type (type=' || v_broker_type || ')');
		END IF;

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		v_report_key					report.report_key%TYPE;

	BEGIN
		IF v_broker_type = 'ODBC' THEN
			v_report_key := put_report_odbc
			(
				v_accession_no, v_patient_id, v_report_stat, v_creator_id, v_creator_name,
				v_create_dttm, v_dictator_id, v_dictator_name, v_dictate_dttm, v_transcriber_id,
				v_transcriber_name, v_transcribe_dttm, v_approver_id, v_approver_name, v_approve_dttm,
				v_reviser_id, v_reviser_name, v_revise_dttm, v_report_type, v_IsFirstReport, 
				v_report_text, v_conclusion
			);
		ELSIF v_broker_type = 'HL7-PACS' THEN
			v_report_key := put_report_hl7_pacs
			(
				v_event_type, v_report_control_id, v_accession_no, v_patient_id, v_report_stat,
				v_creator_id, v_creator_name, v_create_dttm, v_dictator_id, v_dictator_name,
				v_dictate_dttm, v_transcriber_id, v_transcriber_name, v_transcribe_dttm, v_approver_id,
				v_approver_name, v_approve_dttm, v_reviser_id, v_reviser_name, v_revise_dttm,
				v_report_type, v_IsFirstReport, v_report_text, v_conclusion, v_put_report_type
			);
		ELSIF v_broker_type = 'HL7-IHE' THEN
			v_report_key := put_report_hl7_ihe
			(
				v_event_type, v_report_control_id, v_accession_no, v_patient_id, v_report_stat,
				v_creator_id, v_creator_name, v_create_dttm, v_dictator_id, v_dictator_name,
				v_dictate_dttm, v_transcriber_id, v_transcriber_name, v_transcribe_dttm, v_approver_id,
				v_approver_name, v_approve_dttm, v_reviser_id, v_reviser_name, v_revise_dttm,
				v_report_type, v_IsFirstReport, v_report_text, v_conclusion, v_put_report_type
			);
		ELSE
			raise_application_error (-20001, 'found invalid broker type (type=' || v_broker_type || ')');
		END IF;

		RETURN v_report_key;
	END;

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
		v_station_code					IN VARCHAR2 := NULL			--68
	)
	RETURN NUMBER
	IS
		v_patient_key					patient.patient_key%TYPE;

	BEGIN
		-- check required parameter
		/*IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'not found patient id (pid-3)');
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'not found patient_name (pid-5)');
		END IF;
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'not found patient location (pv1-2)');
		END IF;
		IF v_patient_birth_dttm IS NULL THEN
			raise_application_error (-20001, 'not found patient birth dttm (pid-7)');
		END IF;
		IF v_patient_sex IS NULL THEN
			raise_application_error (-20001, 'not found patient sex (pid-8)');
		END IF;
		IF v_race_code IS NULL THEN
			raise_application_error (-20001, 'not found race code (pid-10)');
		END IF;
		IF v_address IS NULL THEN
			raise_application_error (-20001, 'not found patient address (pid-11)');
		END IF;
		IF sp_codedict.exists_code ('TBL0005', v_race_code, 'HL7') = 0 THEN
			raise_application_error (-20001, 'not exists race-code(context_id=TBL0005,scheme=HL7) in codedict table');
		END IF;*/

		IF v_event_type = 'ADT^A01' THEN
			v_patient_key := adt_a01_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name),
				v_middle_name, NULL, NULL),
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A02' THEN
			v_patient_key := adt_a02_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A03' THEN
			v_patient_key := adt_a03_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A04' OR v_event_type = 'ORM^O01' THEN
			v_patient_key := adt_a04_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A06' THEN
			v_patient_key := adt_a04_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A07' THEN
			v_patient_key := adt_a04_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);

		ELSIF v_event_type = 'ADT^A08' THEN
			v_patient_key := adt_a08_ex
			(
				v_event_type, v_patient_id, v_patient_id_issuer_code, SUBSTR(v_patient_ssn, 1, 3) || '-' || SUBSTR(v_patient_ssn, 4, 2) || '-' || SUBSTR(v_patient_ssn, 6, 4),
				sp_util.encode_name(sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL),	-- v_patient_name
				sp_util.upper(v_last_name), sp_util.upper(v_first_name), v_middle_name, NULL, NULL, v_marital_stat, v_confidentiality,
				v_patient_birth_dttm, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, v_email, v_race_code, NVL(v_phone_no, ' '), v_patient_stat, v_account_no,
				v_contact_type, v_fax_no, v_address, v_city, v_state, v_country, v_zipcode,
				v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, v_patient_location,
				v_patient_residence, v_refer_doctor_id, v_consult_doctor_id
			);
		/*
		ELSIF v_event_type = 'ADT^A40' THEN
			v_patient_key := adt_a40 (v_event_type, v_patient_id, v_prior_patient_id);
		*/
		ELSE
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN NUMBER
	IS
		v_order_key						iorder.order_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_patient_key					patient.patient_key%TYPE;
		v_procplan_key					procplan.procplan_key%TYPE;
		v_order_doctor_key				NUMBER;
		v_refer_doctor_key				NUMBER;
		v_filler_order_id1				NUMBER;
		v_visit_key						visit.visit_key%TYPE;
		v_refer_doctor_id2				VARCHAR2(64);
		v_accession_no_opid				VARCHAR2(64);
		v_access_no1					VARCHAR2(64);

	BEGIN
	--  check required parameter
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL (pid-5)');
		END IF;
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'patient location is NULL (pv1-2)');
		END IF;
		IF v_placer_order_id IS NULL THEN
			raise_application_error (-20001, 'placer order id is NULL (orc-2, obr-2)');
		END IF;
		IF v_order_doctor_id IS NULL THEN
			raise_application_error (-20001, 'order doctor id is NULL (aip-3)');
		END IF;
		IF v_refer_doctor_id IS NULL THEN
			v_refer_doctor_id2 := v_order_doctor_id;
			--raise_application_error (-20001, 'refer doctor id is NULL (pv1-8)');
		ELSE
			v_refer_doctor_id2 := v_refer_doctor_id;
		END IF;
		IF v_reqproc_code_value IS NULL THEN
			raise_application_error (-20001, 'requested procedure code value is NULL (obr-4)');
		END IF;
		IF v_reqproc_code_scheme IS NULL THEN
			raise_application_error (-20001, 'requested procedure code scheme is NULL (obr-4)');
		END IF;
		/*
		IF v_order_entry_user_id IS NULL THEN
			raise_application_error (-20001, 'not found entry user id (orc-10)');
		END IF;
		IF v_order_control_id IS NULL THEN
			raise_application_error (-20001, 'not found order control id (orc-1)');
		END IF;
		IF v_reqproc_reason IS NULL THEN
			raise_application_error (-20001, 'not found requested procedure reason (obr-31)');
		END IF;
		*/
	--  check required parameter

		v_patient_key := sp_patient.lookup_key(v_patient_id);
		IF v_patient_key IS NULL THEN
			v_patient_key := put_patient
			(
				'ADT^A04', v_patient_id, NULL, v_patient_id_issuer_code, NULL,
				v_patient_name, v_last_name, v_first_name, v_middle_name, NULL, v_suffix, NULL, v_confidentiality,
				v_patient_birth_dttm, NULL, v_patient_sex, NULL, NULL, NULL, NULL, NULL, NULL,
				v_race_code, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, v_account_no, NULL,
				NULL, NULL, NULL, v_address, NULL, NULL, NULL, NULL,
				v_account_no, 'C', NULL, NULL,
				v_patient_location, v_patient_residence, v_refer_doctor_id2, v_consult_doctor_id,
				NULL, NULL, NULL, NULL
			);
		ELSE
			v_patient_key := put_patient
			(
				'ADT^A08', v_patient_id, NULL, v_patient_id_issuer_code, NULL,
				v_patient_name, v_last_name, v_first_name, v_middle_name, NULL, v_suffix, NULL, v_confidentiality,
				v_patient_birth_dttm, NULL, v_patient_sex, NULL, NULL, NULL, NULL, NULL, NULL,
				v_race_code, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, v_account_no, NULL,
				NULL, NULL, NULL, v_address, NULL, NULL, NULL, NULL,
				v_account_no, 'C', NULL, NULL,
				v_patient_location, v_patient_residence, v_refer_doctor_id2, v_consult_doctor_id,
				NULL, NULL, NULL, NULL
			);
		END IF;

		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, v_reqproc_code_scheme);
		IF v_procplan_key IS NULL THEN
			--raise_application_error (-20001, 'not found procplan_key (codevalue=' || v_reqproc_code_value || ', codescheme=' || v_reqproc_code_scheme ||')');
			v_procplan_key := put_procplan_unmatched(v_reqproc_code_value, v_reqproc_code_scheme, v_reqproc_code_version, v_reqproc_code_meaning);
		END IF;

		v_order_doctor_key := sp_user.lookup_key(v_order_doctor_id);
		IF v_order_doctor_key IS NULL THEN
			--raise_application_error (-20001, 'not found order_doctor (id=' || v_order_doctor_id || ')');
			--v_order_doctor_key := put_user_unmatched(v_order_doctor_id, v_order_doctor_id, v_order_doctor_last_name, v_order_doctor_first_name, 20);
			v_order_doctor_key := put_user_unmatched(v_order_doctor_id, sp_util.upper(v_account_no), sp_util.upper(v_suffix), 20);
		END IF;

		v_refer_doctor_key := sp_user.lookup_key(v_refer_doctor_id2);
		IF v_refer_doctor_key IS NULL THEN
			--raise_application_error (-20001, 'not found order_doctor (id=' || v_order_doctor_id || ')');
			v_refer_doctor_key := put_user_unmatched(v_order_doctor_id, sp_util.upper(v_account_no), sp_util.upper(v_suffix), 20);
		END IF;

		IF LENGTH(v_order_department) >= 16 THEN
			raise_application_error (-20001, 'too large value for department_code column (code=' || v_order_department || ')');
		END IF;

		IF v_order_department IS NOT NULL AND sp_department.exists(v_order_department) = FALSE THEN
			--raise_application_error (-20001, 'not found department_code (code=' || v_order_department || ')');
			put_department_unmatched(v_order_department, v_order_department);
		END IF;

		v_access_no1 := REPLACE(v_access_no, '.', '');
		v_order_key := lookup_order_key(v_access_no1);


	    IF v_event_type = 'SIU^S12' THEN				-- new appointment
	    	IF v_order_key IS NOT NULL THEN
	 			raise_application_error (-20001, 'accession number already exist. (aid=' || v_access_no1 || ')');
			END IF;

			--v_visit_key := sp_visit.addnew(v_patient_key, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				v_refer_doctor_key, NULL, NULL, NULL
			);
			IF v_account_no IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_account_no
				WHERE	visit_key = v_visit_key;
			END IF;

			v_order_key := sp_order.addnew
			(
				v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
				v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
				v_order_callback_phone_no, v_filler_order_id, NULL, NULL, NULL
			);

			v_study_key := sp_study.addnew
			(
				v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
				v_patient_arrange, v_patient_location, v_access_no1, v_study_instance_uid
			);
			--sp_study.update_account_no(v_study_key, v_account_no);
		ELSIF v_event_type = 'SIU^S13' THEN				-- new appointment
			IF v_order_key IS NOT NULL THEN
				raise_application_error (-20001, 'accession number already exist. (aid=' || v_access_no1 || ')');
			END IF;

			--v_visit_key := sp_visit.addnew(v_patient_key, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				v_refer_doctor_key, NULL, NULL, NULL
			);
			IF v_account_no IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_account_no
				WHERE	visit_key = v_visit_key;
			END IF;

			v_order_key := sp_order.addnew
			(
				v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
				v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
				v_order_callback_phone_no, v_filler_order_id, NULL, NULL, NULL
			);

			v_study_key := sp_study.addnew
			(
				v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
				v_patient_arrange, v_patient_location, v_access_no1, v_study_instance_uid
			);

			--sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_event_type = 'SIU^S14' AND v_order_key IS NULL THEN			-- update appointment
			/*
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'accession number not found');
			END IF;
			*/

			--v_visit_key := sp_visit.addnew(v_patient_key, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				v_refer_doctor_key, NULL, NULL, NULL
			);
			IF v_account_no IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_account_no
				WHERE	visit_key = v_visit_key;
			END IF;

			v_order_key := sp_order.addnew
			(
				v_patient_key, v_visit_key, v_placer_order_id, v_order_comments, v_order_comments,
				v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(sp_util.parse_string(v_order_entry_user_id, '^', 1)), v_order_entry_location, 
				v_order_callback_phone_no, NULL, NULL, NULL, NULL
			);

			v_study_key := sp_study.addnew
			(
				v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_code_meaning, v_reqproc_priority,
				v_patient_arrange, v_patient_location, v_access_no1, v_study_instance_uid
			);
		ELSIF v_event_type = 'SIU^S14' AND v_order_key IS NOT NULL THEN			-- update appointment
			/*
			SELECT visit_key INTO v_visit_key
			FROM iorder
			WHERE accession_no = v_access_no;
			*/

			SELECT visit_key INTO v_visit_key
			FROM iorder
			WHERE order_key = v_order_key;

			sp_order.modify
			(
				v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
				v_order_comments, v_order_doctor_key, v_refer_doctor_key, NULL, sp_user.lookup_key(v_order_entry_user_id), 
				v_order_entry_location, v_order_callback_phone_no, NULL, NULL
			);

			SELECT study_key INTO v_study_key
			FROM study
			WHERE access_no = v_access_no1 and procplan_key IS NOT NULL;

			sp_study.modify
			(
				v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
				v_patient_arrange
			);
			
			user_modify(v_study_key, v_refer_doctor_key, v_order_doctor_key, v_order_comments);
		ELSIF v_event_type = 'SIU^S15' THEN			-- cancel appointmetn
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'accession number not found');
				--v_accession_no_opid := lookup_accession_no_opid(v_placer_order_id);
				--v_order_key := sp_order.lookup_key(v_accession_no_opid);
			END IF;

			IF v_access_no1 IS NULL THEN
				v_study_key := lookup_key_acn(v_accession_no_opid);
			ELSE
				v_study_key := lookup_key_acn(v_access_no1);
			END IF;

			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found');
			ELSE
				sp_order.cancel(v_order_key,NULL);
			END IF;

			--sp_msps.cancel_schedule(v_study_key);
			--sp_order.cancel(v_order_key,NULL);
			--sp_hl7routeitem.ormca(v_study_key);
		ELSE
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;

		RETURN v_study_key;
	END;

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
	RETURN NUMBER
	IS
		v_order_key						iorder.order_key%TYPE;

	BEGIN
	--  check required parameter
		IF v_event_type != 'ORR^O02' THEN
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;
		IF v_placer_order_id IS NULL THEN
			raise_application_error (-20001, 'placer_order_id is NULL (orc-2)');
		END IF;
		IF v_filler_order_id IS NULL THEN
			raise_application_error (-20001, 'placer_order_id is NULL (orc-3)');
		END IF;
	--  check required parameter

		SELECT	order_key INTO v_order_key 
		FROM	iorder
		WHERE	filler_order_id = v_filler_order_id;

		IF v_order_key IS NOT NULL THEN
			UPDATE	iorder 
			SET		placer_order_id = v_placer_order_id
			WHERE	order_key = v_order_key;
		ELSE
			raise_application_error (-20001, 'not found order key(fillerid=' || v_filler_order_id || ')');
		END IF;

		RETURN v_order_key;
	END;

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
	)
	IS
		v_pre_allergy_comments				patient.allergy_comments%TYPE;
		v_tmp_allergy_comments				patient.allergy_comments%TYPE;
		v_full_allergy_comments				patient.allergy_comments%TYPE;
	BEGIN
		/*
	 	v_tmp_allergy_comments := v_allergen_type_code ||'^'|| v_allergen_code ||'^'|| v_allergen_desc
			||'^'||	v_allergen_scheme ||'^'|| v_allergy_action_code ||'^'|| v_allergy_action_reason ||'^'|| v_allergy_clinical_status_code
			||'^'||	v_allergy_clinical_status_desc ||'^'|| v_statused_by_person_id ||'^'|| v_statused_by_person_name
			||'^'||	v_statused_by_person_issuer ||'^'||	v_statused_at_dttm ||'^'|| v_clinician_identified_code ||'^'|| v_clinician_identified_desc
			||'^'||	v_clinician_identified_scheme ||'^'|| v_allergy_reaction_code_list ||'^'|| v_allergy_reaction_desc_list
			||'^'||	v_allergy_severity_code_list ||'^'|| v_sens_causative_code_list;
		*/
		
		--v_tmp_allergy_comments := v_allergen_type_code ||'^'|| v_allergen_code ||'^'|| v_allergen_desc || '^' ||v_allergy_reaction_desc_list;
		v_tmp_allergy_comments := v_allergen_type_code ||'^'|| v_allergen_desc || chr(13) || chr(10);

		IF v_index = 1 THEN
			-- update
			UPDATE patient SET allergy_comments = v_tmp_allergy_comments
			WHERE patient_key = v_patient_key;
		ELSE
			-- attach
			SELECT allergy_comments INTO v_pre_allergy_comments
			FROM patient
			WHERE patient_key = v_patient_key;

			v_full_allergy_comments := v_pre_allergy_comments || v_tmp_allergy_comments;

			UPDATE patient 
			SET allergy_comments = v_full_allergy_comments
			WHERE patient_key = v_patient_key;
		END IF;

	END;

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
	)
	IS
		v_ex_policy_no				patientinsurance.insurance_no%TYPE;
		v_patientinsurance_key		patientinsurance.patientinsurance_key%TYPE;
		v_new_insurance_no			VARCHAR2(64);
		v_insurance_code1			VARCHAR2(8);
		v_total						NUMBER;

		CURSOR cv_pinsurance
		IS
			SELECT patientinsurance_key,policy_no
			FROM patientinsurance
			WHERE patient_key = v_patient_key;

	BEGIN
	--  check required parameter
		IF v_company_name IS NULL THEN
			raise_application_error (-20001, 'not found insurance company name (in1-4)');
		END IF;
		/*
		IF v_policy_no IS NULL THEN
			raise_application_error (-20001, 'not found policy no (in1-36)');
		END IF;
		IF v_phone_no IS NULL THEN
			raise_application_error (-20001, 'not found insurance phone number (in1-6)');
		END IF;
		*/
	--  check required parameter

		v_insurance_code1 := sp_insurance.put
		(
			NVL(v_insurance_code, '100'), v_insurance_name, v_company_name, v_phone_no, v_fax_no, 
			v_address, v_city, v_state, v_zipcode, v_country,
			NULL, NULL
		);
		IF v_insurance_code1 IS NULL THEN
			raise_application_error (-2002, 'not found insurance code (inl-5)');
		END IF;

		SELECT	COUNT(0) INTO v_total 
		FROM	patientinsurance
		WHERE	patient_key = v_patient_key 
		AND		policy_no = v_policy_no 
		AND		insurance_code = v_insurance_code1;

		v_new_insurance_no := TO_CHAR(sp_patient.get_last_insurance_no(v_patient_key) + 1);

		IF v_total < 1 THEN
			v_patientinsurance_key := sp_patient.addnew_insurance
			(
				v_patient_key, v_insurance_code1, v_company_name, v_new_insurance_no, v_health_plan,
				v_policy_no, v_group_name, v_group_no, sp_util.to_dttm(SUBSTR(v_plan_effect_dttm, 1,8)), sp_util.to_dttm(SUBSTR(v_plan_effect_dttm, 1,8)),
				NULL, v_company_name, v_phone_no, v_fax_no, v_address, 
				v_city, v_state, v_zipcode, v_country, NULL, 
				sp_util.to_dttm(SUBSTR(v_insured_birth_dttm,1,8)), v_insured_sex, v_insured_ssn, v_last_name, v_first_name, 
				v_middle_name, v_prefix, v_suffix, v_insured_phone_no, v_insured_fax_no, 
				v_insured_address, v_insured_city, v_insured_state, v_insured_zipcode, v_insured_country, 
				v_insurance_type
			);
		ELSE
			SELECT	patientinsurance_key, policy_no INTO v_patientinsurance_key, v_ex_policy_no
			FROM	patientinsurance 
			WHERE	patient_key = v_patient_key 
			AND		policy_no = v_policy_no 
			AND		insurance_code = v_insurance_code1;

			sp_patient.modify_insurance
			(
				v_patientinsurance_key, v_insurance_code1, v_company_name, v_new_insurance_no, v_health_plan,
				v_policy_no, v_group_name, v_group_no, sp_util.to_dttm(SUBSTR(v_plan_effect_dttm, 1,8)), sp_util.to_dttm(SUBSTR(v_plan_effect_dttm, 1,8)),
				NULL, v_company_name, v_phone_no, v_fax_no, v_address, 
				v_city, v_state, v_zipcode, v_country, NULL, 
				sp_util.to_dttm(SUBSTR(v_insured_birth_dttm,1,8)), v_insured_sex, v_insured_ssn, v_last_name, v_first_name, 
				v_middle_name, v_prefix, v_suffix, v_insured_phone_no, v_insured_fax_no, 
				v_insured_address, v_insured_city, v_insured_state, v_insured_zipcode, v_insured_country, 
				v_insurance_type
			);
		END IF;

		/*
		OPEN cv_pinsurance;
		LOOP
			FETCH cv_pinsurance INTO v_patientinsurance_key,v_ex_policy_no;
			EXIT WHEN cv_pinsurance%NOTFOUND;

			v_new_insurance_no := TO_CHAR(sp_patient.get_last_insurance_no(v_patient_key) + 1);

			IF v_ex_policy_no = v_policy_no THEN
				sp_patient.modify_insurance(v_patientinsurance_key,
					v_insurance_code1, v_company_name, v_new_insurance_no, v_health_plan,		    -- insurance
					v_policy_no, v_group_name, v_group_no, sp_util.to_dttm(SUBSTR(v_plan_effect_dttm,1,8)), sp_util.to_dttm(SUBSTR(v_plan_expire_dttm,1,8)),
					NULL, v_company_name, v_phone_no, v_fax_no, v_address, v_city,
					v_state, v_zipcode, v_country, NULL, sp_util.to_dttm(SUBSTR(v_insured_birth_dttm,1,8)),
					v_insured_sex, v_insured_ssn, v_last_name, v_first_name, v_middle_name,
					v_prefix, v_suffix, v_insured_phone_no, v_insured_fax_no, v_insured_address,
					v_insured_city, v_insured_state, v_insured_zipcode, v_insured_country, v_insurance_type);

					EXIT;
			ELSE
				v_patientinsurance_key := sp_patient.addnew_insurance(v_patient_key,
					v_insurance_code1, v_company_name, v_new_insurance_no, v_health_plan,		    -- insurance
					v_policy_no, v_group_name, v_group_no, sp_util.to_dttm(SUBSTR(v_plan_effect_dttm,1,8)), sp_util.to_dttm(SUBSTR(v_plan_expire_dttm,1,8)),
					NULL, v_company_name, v_phone_no, v_fax_no, v_address, v_city,
					v_state, v_zipcode, v_country, NULL, sp_util.to_dttm(SUBSTR(v_insured_birth_dttm,1,8)),
					v_insured_sex, v_insured_ssn, v_last_name, v_first_name, v_middle_name,
					v_prefix, v_suffix, v_insured_phone_no, v_insured_fax_no, v_insured_address,
					v_insured_city, v_insured_state, v_insured_zipcode, v_insured_country, v_insurance_type);
			END IF;

		END LOOP;

		IF v_patientinsurance_key IS NULL THEN
				v_new_insurance_no := TO_CHAR(sp_patient.get_last_insurance_no(v_patient_key) + 1);

				v_patientinsurance_key := sp_patient.addnew_insurance(v_patient_key,
					v_insurance_code1, v_company_name, v_new_insurance_no, v_health_plan,		    -- insurance
					v_policy_no, v_group_name, v_group_no, sp_util.to_dttm(SUBSTR(v_plan_effect_dttm,1,8)), sp_util.to_dttm(SUBSTR(v_plan_expire_dttm,1,8)),
					NULL, v_company_name, v_phone_no, v_fax_no, v_address, v_city,
					v_state, v_zipcode, v_country, NULL, sp_util.to_dttm(SUBSTR(v_insured_birth_dttm,1,8)),
					v_insured_sex, v_insured_ssn, v_last_name, v_first_name, v_middle_name,
					v_prefix, v_suffix, v_insured_phone_no, v_insured_fax_no, v_insured_address,
					v_insured_city, v_insured_state, v_insured_zipcode, v_insured_country, v_insurance_type);
		END IF;

		CLOSE cv_pinsurance;
*/
	END;
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
	)
	IS
		v_patientgrt_key			NUMBER;	
		v_total						NUMBER;
	--	v_guarantor_name 			patientguarantor.guarantor_name%TYPE;
		
	BEGIN
		IF v_gtr_last_name IS NULL THEN
			raise_application_error(-20001,'not found guarantor last name(GT1.3)');
		END IF;
		/*IF v_gtr_first_name IS NULL THEN
			raise_application_error(-20001,'not found guarantor first name(GT1.3)');
		END IF;
		*/
		SELECT COUNT(0) INTO v_total FROM patientguarantor
		WHERE patient_key = v_patient_key AND last_name = v_gtr_last_name ;
		
		IF v_total < 1 THEN
			v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
					v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
					v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			
					v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
					v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
					v_gtr_emp_country, v_gtr_emp_comments);
		ELSE
			SELECT patientguarantor_key INTO v_patientgrt_key FROM patientguarantor 
			WHERE patient_key = v_patient_key AND last_name = v_gtr_last_name;	
			
			sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
					v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
					v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			
					v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
					v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
					v_gtr_emp_country, v_gtr_emp_comments);
		END IF;
		
		
	END;
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
	RETURN users.user_key%TYPE
	IS
		v_user_key						users.user_key%TYPE;
		v_usercontact_key				usercontact.usercontact_key%TYPE;
		v_home_address					usercontact.address%TYPE;
		v_office_address				usercontact.address%TYPE;
		v_ret							NUMBER;
	BEGIN
		v_user_key := sp_user.lookup_key(v_user_id);
		IF v_user_key IS NULL THEN
			-- add new user
			v_user_key := sp_user.addnew
			(
				v_user_id, v_user_last_name, v_user_first_name, v_user_middle_name, v_user_prefix, 
				v_user_suffix, v_user_stat, TO_NUMBER(v_user_level_code), v_user_license_no, NULL, 
				v_user_email, v_user_cell_phone_no, NULL, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, sp_util.upper(v_user_name)
			);
			
			v_ret := sp_user.set_password(v_user_key, v_user_password);
			
			-- add new usercontact
			IF v_user_contact_type = 'H' THEN		-- H: Home
				v_home_address := SUBSTR((v_user_home_address_1 || ' ' || v_user_home_address_2), 1, 128);
				v_usercontact_key := sp_user.addnew_contact
				(
					v_user_key, v_user_contact_type, v_user_home_phone_no, v_user_home_fax_no, v_home_address,
					v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
					NULL
				);
			ELSIF v_user_contact_type = 'O' THEN	-- O: Office
				v_office_address := SUBSTR((v_user_office_address_1 || ' ' || v_user_office_address_2), 1, 128);
				v_usercontact_key := sp_user.addnew_contact
				(
					v_user_key, v_user_contact_type, v_user_office_phone_no, v_user_office_fax_no, v_office_address,
					v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
					NULL
				);
			ELSIF v_user_contact_type = 'B' THEN	-- B: Home and Office
				v_home_address := SUBSTR((v_user_home_address_1 || ' ' || v_user_home_address_2), 1, 128);
				v_usercontact_key := sp_user.addnew_contact
				(
					v_user_key, 'H', v_user_home_phone_no, v_user_home_fax_no, v_home_address,
					v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
					NULL
				);

				v_office_address := SUBSTR((v_user_office_address_1 || ' ' || v_user_office_address_2), 1, 128);
				v_usercontact_key := sp_user.addnew_contact
				(
					v_user_key, 'O', v_user_office_phone_no, v_user_office_fax_no, v_office_address,
					v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
					NULL
				);
			END IF;
		ELSE
			-- update user
			sp_user.modify
			(
				v_user_key, v_user_last_name, v_user_first_name, v_user_middle_name, v_user_prefix,
				v_user_suffix, v_user_stat, TO_NUMBER(v_user_level_code), v_user_license_no, NULL,
				v_user_email, v_user_cell_phone_no, NULL, NULL, NULL,
				NULL, NULL, NULL, NULL, NULL,
				NULL, sp_util.upper(v_user_name)
			);

			v_ret := sp_user.set_password(v_user_key, v_user_password);

			-- update usercontact
			IF v_user_contact_type = 'H' THEN		--Home
				v_home_address := SUBSTR((v_user_home_address_1 || ' ' || v_user_home_address_2), 1, 128);
				v_usercontact_key := sp_mapper.lookup_usercontact_key(v_user_key, v_user_contact_type);
				IF v_usercontact_key IS NOT NULL THEN
					sp_user.modify_contact
					(
						v_usercontact_key, v_user_contact_type, v_user_home_phone_no, v_user_home_fax_no, v_home_address,
						v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
						NULL
					);
				ELSE
					v_usercontact_key := sp_user.addnew_contact
					(
						v_user_key, v_user_contact_type, v_user_home_phone_no, v_user_home_fax_no, v_home_address,
						v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
						NULL
					);
				END IF;
			ELSIF v_user_contact_type = 'O' THEN	--Office
				v_office_address := SUBSTR((v_user_office_address_1 || ' ' || v_user_office_address_2), 1, 128);
				v_usercontact_key := sp_mapper.lookup_usercontact_key(v_user_key, v_user_contact_type);
				IF v_usercontact_key IS NOT NULL THEN
					sp_user.modify_contact
					(
						v_usercontact_key, v_user_contact_type, v_user_office_phone_no, v_user_office_fax_no, v_office_address,
						v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
						NULL
					);
				ELSE
					v_usercontact_key := sp_user.addnew_contact
					(
						v_user_key, v_user_contact_type, v_user_office_phone_no, v_user_office_fax_no, v_office_address,
						v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
						NULL
					);
				END IF;
			ELSIF v_user_contact_type = 'B' THEN	--Home and Office
				v_home_address := SUBSTR((v_user_home_address_1 || ' ' || v_user_home_address_2), 1, 128);
				v_usercontact_key := sp_mapper.lookup_usercontact_key(v_user_key, 'H');
				IF v_usercontact_key IS NOT NULL THEN
					sp_user.modify_contact
					(
						v_usercontact_key, 'H', v_user_home_phone_no, v_user_home_fax_no, v_home_address,
						v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
						NULL
					);
				ELSE
					v_usercontact_key := sp_user.addnew_contact
					(
						v_user_key, 'H', v_user_home_phone_no, v_user_home_fax_no, v_home_address,
						v_user_home_city, v_user_home_state, v_user_home_zipcode, v_user_home_country, NULL,
						NULL
					);
				END IF;

				v_office_address := SUBSTR((v_user_office_address_1 || ' ' || v_user_office_address_2), 1, 128);
				v_usercontact_key := sp_mapper.lookup_usercontact_key(v_user_key, 'O');
				IF v_usercontact_key IS NOT NULL THEN
					sp_user.modify_contact
					(
						v_usercontact_key, 'O', v_user_office_phone_no, v_user_office_fax_no, v_office_address,
						v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
						NULL
					);
				ELSE
					v_usercontact_key := sp_user.addnew_contact
					(
						v_user_key, 'O', v_user_office_phone_no, v_user_office_fax_no, v_office_address,
						v_user_office_city, v_user_office_state, v_user_office_zipcode, v_user_office_country, NULL,
						NULL
					);
				END IF;
			END IF;
		END IF;

		RETURN v_user_key;
	END;

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
	RETURN users.user_key%TYPE
	IS
		v_user_key						users.user_key%TYPE;
		v_ret							NUMBER;
		v_last_name						users.last_name%TYPE := NULL;
		v_first_name					users.first_name%TYPE := NULL;
		v_middle_name					users.middle_name%TYPE := NULL;
		v_prefix						users.prefix%TYPE := NULL;
		v_suffix						users.suffix%TYPE := NULL;
	BEGIN
		v_user_key := sp_user.lookup_key(v_user_id);

		IF v_user_key IS NOT NULL THEN
			/*
			UPDATE	users
			SET		user_name = SUBSTR(v_user_name,1,64),
					level_code = TO_NUMBER(v_user_level),
					user_stat = v_user_status
			WHERE	user_key = v_user_key;
			*/
			IF sp_profile.get_string('USER', 'USER_NAME', 'ENCODE_NAME') != 'SIMPLE_NAME' THEN
				sp_util.decode_name(v_user_name, v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix);
			END IF;
			
			sp_user.modify
			(
				v_user_key, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_user_status, TO_NUMBER(v_user_level), NULL, NULL,
				NULL, NULL, NULL, NULL, NULL,
				NULL, NULL, NULL, NULL, NULL,
				NULL, sp_util.upper(v_user_name)
			);

			v_ret := sp_user.set_password(v_user_key, v_password);

		ELSE
			v_user_key := sp_user.addnew(v_user_id, v_password, v_user_name, v_user_status, TO_NUMBER(v_user_level));

		END IF;

		RETURN v_user_key;
	END;

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
	)
	IS
	BEGIN
		IF SUBSTR(v_event_type, 1, 4) = 'ORM^' THEN
			orm_put
			(
				v_order_control_id, v_character_set, v_scheduled_aetitle, TO_DATE(v_scheduled_dttm,'YYYYMMDDHH24MISS'), v_scheduled_modality, 
				v_scheduled_station, v_scheduled_location, v_scheduled_proc_id, v_scheduled_proc_desc, v_scheduled_action_codes, 
				v_scheduled_proc_status, v_premedication, v_contrast_agent, v_requested_proc_id, v_requested_proc_desc, 
				v_requested_proc_codes, v_requested_proc_priority, v_requested_proc_reason, v_requested_proc_comments, v_study_instance_uid, 
				v_proc_placer_order_no, v_proc_filler_order_no, v_accession_no, v_attend_doctor, v_perform_doctor, 
				v_consult_doctor, v_request_doctor, v_refer_doctor, v_request_department, v_imaging_request_reason, 
				v_imaging_request_comments, TO_DATE(v_imaging_request_dttm, 'YYYYMMDDHH24MISS'), v_isr_placer_order_no, v_isr_filler_order_no, v_admission_id, 
				v_patient_transport, v_patient_location, v_patient_residency, v_patient_name, v_patient_id, 
				v_other_patient_name, v_other_patient_id, TO_DATE(v_patient_birth_dttm, 'YYYYMMDD'), v_patient_sex, v_patient_weight, 
				v_patient_size, v_patient_state, v_confidentiality, v_pregnancy_status, v_medical_alerts, 
				v_contrast_allergies, v_special_needs, v_specialty, v_diagnosis, TO_DATE(v_admit_dttm, 'YYYYMMDDHH24MISS'), 
				TO_DATE(v_register_dttm, 'YYYYMMDDHH24MISS'), v_study_ssn
			);

		ELSE
			mwl_put
			(
				v_character_set, v_scheduled_aetitle, v_scheduled_dttm, v_scheduled_modality, v_scheduled_station, 
				v_scheduled_location, v_scheduled_proc_id, v_scheduled_proc_desc, v_scheduled_action_codes, v_scheduled_proc_status, 
				v_premedication, v_contrast_agent, v_requested_proc_id, v_requested_proc_desc, v_requested_proc_codes, 
				v_requested_proc_priority, v_requested_proc_reason, v_requested_proc_comments, v_study_instance_uid, v_proc_placer_order_no, 
				v_proc_filler_order_no, v_accession_no, v_attend_doctor, v_perform_doctor, v_consult_doctor, 
				v_request_doctor, v_refer_doctor, v_request_department, v_imaging_request_reason, v_imaging_request_comments, 
				v_imaging_request_dttm,  v_isr_placer_order_no, v_isr_filler_order_no, v_admission_id, v_patient_transport, 
				v_patient_location, v_patient_residency, v_patient_name, v_patient_id, v_other_patient_name, 
				v_other_patient_id, v_patient_birth_dttm, v_patient_sex, v_patient_weight, v_patient_size, 
				v_patient_state, v_confidentiality, v_pregnancy_status, v_medical_alerts, v_contrast_allergies, 
				v_special_needs, v_specialty, v_diagnosis, v_admit_dttm, v_register_dttm, 
				v_study_ssn 
			);

		END IF;

	END;


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
	RETURN NUMBER
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patient_birth_dttm_temp		VARCHAR2(14);
		v_patient_id_issuer				VARCHAR2(32);		
	BEGIN
	--  check required parameter
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL(pid-3)');
		END IF;
		IF v_patient_id_issuer_code IS NULL OR v_patient_id_issuer_code = '' THEN
			IF v_institution_code IS NOT NULL THEN
				v_patient_id_issuer := get_issuer_code(v_institution_code);
			ELSE
				v_patient_id_issuer := get_issuer_code(get_institution_code);
			END IF;
		ELSE
			v_patient_id_issuer := v_patient_id_issuer_code;
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL(pid-5)');
		END IF;
		IF v_last_name IS NULL THEN
			raise_application_error (-20001, 'last_name is NULL(pid-5.1)');
		END IF;
		IF v_patient_birth_dttm IS NULL THEN
			--raise_application_error (-20001, 'patient birth dttm is NULL(pid-7)');
			v_patient_birth_dttm_temp := TO_CHAR(SYSDATE, 'YYYYMMDD');
		ELSE
			v_patient_birth_dttm_temp := v_patient_birth_dttm;
		END IF;
		/*
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'patient location is NULL(pv1-2)');
		END IF;
		IF v_patient_sex IS NULL THEN
			raise_application_error (-20001, 'patient sex is NULL(pid-8)');
		END IF;
		IF v_race_code IS NULL THEN
			raise_application_error (-20001, 'race code is NULL(pid-10)');
		END IF;
		IF v_address IS NULL THEN
			raise_application_error (-20001, 'patient address is NULL(pid-11)');
		END IF;
		IF sp_codedict.exists_code ('TBL0005', v_race_code, 'HL7') = 0 THEN
			raise_application_error (-20001, 'not exists race-code(context_id=TBL0005,scheme=HL7) in codedict table');
		END IF;
		*/
	--  check required parameter

		IF v_event_type = 'ADT^A01' THEN
			v_patient_key := adt_a01
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A03' THEN
			v_patient_key := adt_a03
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A04' THEN
			v_patient_key := adt_a04
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A08' THEN
			v_patient_key := adt_a08
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A28' THEN
			v_patient_key := adt_a28
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A31' THEN
			v_patient_key := adt_a31
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A30' OR v_event_type = 'ADT^A40' THEN
			v_patient_key := adt_a40 (v_event_type, v_patient_id, v_prior_patient_id, v_patient_id_issuer);
		ELSIF v_event_type = 'ADT^A11' OR v_event_type = 'ADT^A38' THEN   -- cancel admit.
			v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		ELSE
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN NUMBER
	IS
		v_order_key						iorder.order_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_patient_key					patient.patient_key%TYPE;
		v_procplan_key					procplan.procplan_key%TYPE;
		v_order_doctor_key				NUMBER;
		v_refer_doctor_key				NUMBER;
		v_access_no1					NUMBER;
		v_filler_order_id1				NUMBER;
		v_visit_key						visit.visit_key%TYPE;
		v_refer_doctor_id2				VARCHAR2(32);
		v_accession_no_opid				VARCHAR2(32);

		v_default_code_scheme			VARCHAR2(32);
		v_patient_id_issuer				VARCHAR2(32);
		v_new_study_instance_uid		VARCHAR2(64);

		v_info_value					VARCHAR2(4000);
		v_user_name						users.user_name%TYPE;
		v_user_alias_name			users.alias_name%TYPE;
		v_diag_key						diagcode.diag_key%TYPE;
		
		v_enable_veterinary_pacs 			VARCHAR2(3);
		v_veterinary_key							veterinary.veterinary_key%TYPE;
		v_vet_sex_neutered_cd_key  		codedict.code_key%TYPE;
		v_vet_rps_prsn_cd_key 				codedict.code_key%TYPE;
		v_studydiag_exist				NUMBER;
		
	BEGIN
	--  check required parameter
		IF v_event_type != 'ORM^O01' AND v_event_type != 'OMG^O19' AND v_event_type != 'OMI^O23' THEN
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL (pid-5)');
		END IF;
		IF v_order_control_id IS NULL THEN
			raise_application_error (-20001, 'order control id is NULL (orc-1)');
		END IF;
		IF v_order_doctor_id IS NULL THEN
			raise_application_error (-20001, 'order doctor id is NULL (orc-12)');
		END IF;
		IF v_refer_doctor_id IS NULL THEN
			--raise_application_error (-20001, 'refer doctor id is NULL (pv1-8)');
			v_refer_doctor_id2 := v_order_doctor_id;
		ELSE
			v_refer_doctor_id2 := v_refer_doctor_id;
		END IF;
		IF v_reqproc_code_value IS NULL THEN
			raise_application_error (-20001, 'requested procedure code value is NULL (obr-4.1)');
		END IF;
		IF v_access_no IS NULL THEN
			raise_application_error (-20001, 'accession number is NULL (obr-18)');
		END IF;
		IF v_patient_id_issuer_code IS NULL OR v_patient_id_issuer_code = '' THEN
			v_patient_id_issuer := get_issuer_code(get_institution_code);
		ELSE
			v_patient_id_issuer := v_patient_id_issuer_code;
		END IF;
		/*
		IF v_patient_birth_dttm IS NULL THEN
			raise_application_error (-20001, 'patient birth dttm is NULL (pid-7)');
		END IF;
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'patient location is NULL (pv1-2)');
		END IF;
		IF v_placer_order_id IS NULL THEN
			raise_application_error (-20001, 'placer order id is NULL (orc-2, obr-2)');
		END IF;
		IF v_order_entry_user_id IS NULL THEN
			raise_application_error (-20001, 'entry user id is NULL (orc-10)');
		END IF;
		IF v_order_department IS NULL THEN
			raise_application_error (-20001, 'order department is NULL (orc-17)');
		END IF;
		IF v_reqproc_code_scheme IS NULL THEN
			raise_application_error (-20001, 'requested procedure code scheme is NULL (obr-4.3)');
		END IF;
		IF v_order_stat = 'SC' THEN		-- check procedure scheduled (s-orm inbound)
			IF v_patient_sex IS NULL THEN
				raise_application_error (-20001, 'patient sex is NULL (pid-8)');
			END IF;
			IF sp_codedict.exists_code ('TBL0005', v_race_code, 'HL7') = 0 THEN
				raise_application_error (-20001, 'not exists race-code(context_id=TBL0005,scheme=HL7) in codedict table');
			END IF;
			IF v_address IS NULL THEN
				raise_application_error (-20001, 'patient address is NULL (pid-11)');
			END IF;
			IF v_consult_doctor_id IS NULL THEN
				raise_application_error (-20001, 'consult doctor id is NULL (pv1-9)');
			END IF;
			IF v_filler_order_id IS NULL THEN
				raise_application_error (-20001, 'filler order id is NULL (orc-3, obr-3)');
			END IF;
			IF v_order_entry_location IS NULL THEN
				raise_application_error (-20001, 'order entry location is NULL (orc-13)');
			END IF;
			IF v_reqproc_priority IS NULL THEN
				raise_application_error (-20001, 'priority is NULL (obr-5)');
			END IF;
			IF v_reqproc_id IS NULL THEN
				raise_application_error (-20001, 'requested procedure id is NULL (obr-19)');
			END IF;
			IF v_study_instance_uid IS NULL THEN
				raise_application_error (-20001, 'study instance uid is NULL (zds-1)');
			END IF;
			IF v_patient_arrange IS NULL THEN
				raise_application_error (-20001, 'transport arranged is NULL (obr-41)');
			END IF;
		END IF;
		*/
	--  check required parameter

		v_default_code_scheme := get_institution_code(v_patient_id_issuer);

		IF v_study_instance_uid IS NOT NULL AND sp_profile.get_boolean('ORDER', 'USE_THIRD_PARTY_WORKLIST_GATEWAY', 0) = 1 THEN
			IF LENGTH(v_study_instance_uid) <= 58 THEN
				v_new_study_instance_uid := v_study_instance_uid || '.99' || LPAD(ROUND(DBMS_RANDOM.VALUE(1,999)),3,0);
			ELSE
				v_new_study_instance_uid := v_study_instance_uid || '.98';
			END IF;
		ELSE
			v_new_study_instance_uid := v_study_instance_uid;
		END IF;

		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		IF v_patient_key IS NULL THEN
			--raise_application_error (-20001, 'not found patient (pid=' || v_patient_id || ', idissuer=' || v_patient_id_issuer ||')');
			v_patient_key := put_patient
			(
				'ADT^A04', v_patient_id, NULL, v_patient_id_issuer, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix, 
				v_suffix, NULL, v_confidentiality, v_patient_birth_dttm, NULL, 
				v_patient_sex, NULL, NULL, NULL, NULL, 
				NULL, NULL, v_race_code, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, v_account_no, 'H', NULL, 
				NULL, NULL, v_address, NULL, NULL, 
				NULL, NULL, v_account_no, 'C', NULL, 
				NULL, v_patient_location, v_patient_residence, v_refer_doctor_id2, v_consult_doctor_id,
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL,'HL7-PACS'
			);
		END IF;

		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme));
		IF v_procplan_key IS NULL THEN
			--raise_application_error (-20001, 'not found procplan_key (codevalue=' || v_reqproc_code_value || ', codescheme=' || v_reqproc_code_scheme ||')');
			v_procplan_key := put_procplan_unmatched(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme), v_reqproc_code_version, v_reqproc_code_meaning);
		END IF;

		v_order_doctor_key := sp_user.lookup_key(v_order_doctor_id);
		IF v_order_doctor_key IS NULL THEN
			--raise_application_error (-20001, 'not found order_doctor (id=' || v_order_doctor_id || ')');
			v_order_doctor_key := put_user_unmatched(v_order_doctor_id, 40);
		END IF;

		v_refer_doctor_key := sp_user.lookup_key(v_refer_doctor_id2);
		IF v_refer_doctor_key IS NULL THEN
			--raise_application_error (-20001, 'not found refer_doctor (id=' || v_refer_doctor_id2 || ')');
			v_refer_doctor_key := put_user_unmatched(v_refer_doctor_id2, 20);
		END IF;

		IF LENGTH(v_order_department) >= 16 THEN
			raise_application_error (-20001, 'too large value for department_code column (code=' || v_order_department || ')');
		END IF;
		
		IF v_order_department IS NOT NULL THEN
			IF sp_department.exists(v_order_department) = FALSE THEN
				--raise_application_error (-20001, 'not exists order department code in department table (code=' || v_order_department || ')');
				put_department_unmatched(v_order_department, v_order_department);
			END IF;
		END IF;

		v_order_key := sp_order.lookup_key(v_access_no);

		IF v_order_control_id = 'NW' THEN
			IF v_order_key IS NOT NULL THEN
				raise_application_error (-20001, 'accession number already exist. (acn=' || v_access_no || ')');
			END IF;

			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
				v_refer_doctor_key, NULL, NULL, NULL
			);
			IF v_account_no IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_account_no
				WHERE	visit_key = v_visit_key;
			END IF;

			v_order_key := sp_order.addnew
			(
				v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
				v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
				v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
			);
			-- set iorderinfo (ordered)
			SELECT	user_name, alias_name
			INTO	v_user_name, v_user_alias_name
			FROM	users
			WHERE	user_key = v_refer_doctor_key;
			v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
			sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

			v_study_key := sp_study.addnew
			(
				v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
				v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
			);

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'CA' THEN
			IF v_order_key IS NULL THEN
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
			END IF;
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
			END IF;

			IF v_access_no IS NULL THEN
				--v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
				v_study_key := sp_study.lookup_key_order(v_order_key);
			ELSE
				v_study_key := sp_study.lookup_key_acn(v_access_no);
			END IF;

			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found (acn=' || v_access_no || ')');
			END IF;

			sp_order.cancel(v_order_key, NULL);

			-- set studyinfo (canceled)
			SELECT	user_name, alias_name
			INTO	v_user_name, v_user_alias_name
			FROM	users
			WHERE	user_key = v_refer_doctor_key;
			v_info_value := 'C' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
			sp_study.set_study_info(v_study_key, 'CANCELED', v_info_value);

		ELSIF v_order_control_id = 'XO' THEN
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				/*
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);
				*/

			ELSE
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);
				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;

				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'SC' THEN
			IF v_order_key IS NULL THEN
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);

			ELSE
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);
				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;
				
				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'DC' THEN
			RETURN -1;
		ELSE
			raise_application_error (-20001, 'found invalid order_control_id (id=' || v_order_control_id || ')');
		END IF;
		
		-- issuer46099 20150407  by khchoi 
		IF v_diagnosis_code IS NOT NULL THEN
			v_diag_key := sp_diagcode.put(v_diagnosis_code, 'ICD', '10CM', v_diagnosis_code_meaning);
			
			SELECT	COUNT(1)
			INTO	v_studydiag_exist
			FROM	DUAL
			WHERE	EXISTS
					(	SELECT	1
						FROM	studydiag
						WHERE 	study_key = v_study_key
						AND 	diag_key = v_diag_key
						AND 	diag_type = 'A'
					);
			
			IF v_studydiag_exist = 0 THEN
				sp_study.addnew_diagcode(v_study_key, v_diag_key);
			END IF;
			
		END IF;
		
		-- [#93075] veterinary by khchoi
		SELECT value
		INTO	v_enable_veterinary_pacs
		FROM 	profile
		WHERE section = 'SYSTEM'
		AND 	entry = 'ENABLE_VETERINARY_PACS';
		
		IF v_enable_veterinary_pacs = 'T' THEN
		
		  IF v_vet_sex_neutered IS NOT NULL THEN
			
				v_vet_sex_neutered_cd_key := sp_codedict.lookup_code_key('VET01', v_vet_sex_neutered, 'DCM', NULL);
				IF v_vet_sex_neutered_cd_key IS NULL THEN
					v_vet_sex_neutered_cd_key := sp_codedict.addnew_code('VET01', v_vet_sex_neutered, 'DCM', NULL, INITCAP(v_vet_sex_neutered), NULL, NULL);
				END IF;
			
			END IF;
			
			IF v_nk1_relationship IS NOT NULL THEN

				v_vet_rps_prsn_cd_key := sp_codedict.lookup_code_key('VET02', v_nk1_relationship, 'DCM', NULL);
				IF v_vet_rps_prsn_cd_key IS NULL THEN
					v_vet_rps_prsn_cd_key := sp_codedict.addnew_code('VET02', v_nk1_relationship, 'DCM', NULL, INITCAP(v_nk1_relationship), NULL, NULL);
				END IF;
			
			END IF;
				
			sp_veterinary.addnew(v_veterinary_key, 0, v_study_key, v_species_code_description,
														v_breed_code_description, v_vet_sex_neutered_cd_key, v_nk1_name, v_vet_rps_prsn_cd_key, v_nk1_organization_name);
		END IF;

		RETURN v_study_key;
	END;

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
	RETURN NUMBER
	IS
		v_procplan_key					procplan.procplan_key%TYPE;
		v_station_key					station.station_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;

		v_default_code_scheme			VARCHAR2(32);
		v_protocol_key					protocol.protocol_key%TYPE;
		v_procprotcnt					NUMBER;

		v_patient_id_issuer				VARCHAR2(32);
		v_exists						BOOLEAN;
		v_institution_code				VARCHAR2(32);

	BEGIN
	--  check required parameter
		IF v_modality IS NULL THEN
			raise_application_error (-20001, 'modality is NULL (obr-24)');
		END IF;
		IF v_protcode_meaning IS NULL THEN
			raise_application_error (-20001, 'protcode meaning is NULL (obr-4.5)');
		END IF;
		/*
		IF v_sps_start_dttm IS NULL THEN
			raise_application_error (-20001, 'sps start dttm is NULL (obr-27)');
		END IF;
		IF v_protcode_value IS NULL THEN
			raise_application_error (-20001, 'protcode value is NULL (obr-4.4)');
		END IF;
		IF v_protcode_scheme IS NULL THEN
			raise_application_error (-20001, 'protcode scheme is NULL (obr-4.6)');
		END IF;
		*/
	--  check required parameter

		v_patient_id_issuer := sp_study.get_patient_id_issuer(v_study_key);
		IF v_patient_id_issuer IS NULL OR v_patient_id_issuer = '' THEN   
			v_patient_id_issuer := get_issuer_code(get_institution_code);
		END IF;
		
		v_default_code_scheme := get_institution_code(v_patient_id_issuer);
		v_institution_code := get_institution_code(v_patient_id_issuer);

	-- lookup modality
		v_exists := sp_modality.exists(v_modality);
		IF v_exists = FALSE THEN
			--raise_application_error (-20001, 'not exists modality code in modality table (modcode=' || v_modality || ')');
			sp_modality.addnew(v_modality, v_modality, NULL);
		END IF;

	-- lookup procplan
		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme));
		IF v_procplan_key IS NULL THEN
			raise_application_error (-20001, 'procplan_key not found (codevalue=' || v_reqproc_code_value || ', codescheme=' || NVL(v_reqproc_code_scheme, v_default_code_scheme) ||')');
		END IF;

	-- lookup protocol
		v_protocol_key := lookup_protocol_key(v_protcode_meaning, v_modality);
		IF v_protocol_key IS NULL THEN
			--dbms_output.put_line('v_protcode_meaning=' || v_protcode_meaning );
			v_protocol_key := sp_protocol.addnew(v_protcode_meaning, v_modality, NULL, NULL, NULL, NULL, NULL, NULL);
			sp_procplan.link_procplan_protocol(v_procplan_key, v_protocol_key);
		ELSE
			SELECT	COUNT(0) INTO v_procprotcnt FROM procplanprotocol
			WHERE	procplan_key = v_procplan_key
			AND		protocol_key = v_protocol_key;

			IF v_procprotcnt = 0 THEN
				sp_procplan.link_procplan_protocol(v_procplan_key, v_protocol_key);
			END IF;
		END IF;
        dbms_output.put_line('v_default_code_scheme:' || v_default_code_scheme);

	-- lookup station
		v_station_key := lookup_station_key_by_modality(v_modality);
		IF v_station_key IS NULL THEN
			--raise_application_error (-20001, 'station key not found (modcode=' || v_modality || ')');
			v_station_key := put_station_unmatched(v_modality, v_modality, v_institution_code);
		END IF;

		v_msps_key := put_msps_ex_hl7_pacs 
		(
			v_study_key, v_procplan_key, v_station_key, v_sps_id, v_modality, 
			v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index,
			v_order_control_id, v_order_stat
		);

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		CURSOR cv_protocol IS
			SELECT protocol_key
			FROM procplanprotocol
			WHERE procplan_key = v_procplan_key;

		v_protocol_key					protocol.protocol_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;
		v_count							NUMBER;
		v_sps_end_dttm					msps.sps_end_dttm%TYPE;
		v_visit_key						visit.visit_key%TYPE;

		v_user_key						users.user_key%TYPE;
		v_user_name						users.user_name%TYPE;
		v_user_alias_name				users.alias_name%TYPE;
		v_info_value					VARCHAR2(4000);

	BEGIN
		v_count := 1;

		OPEN cv_protocol;
		LOOP
			FETCH cv_protocol INTO v_protocol_key;
			IF cv_protocol%NOTFOUND THEN
				IF v_count = 1 THEN
					raise_application_error (-20001, 'not found protocol_key (procplan_key='|| v_procplan_key ||')');
				ELSE
					RETURN v_msps_key;
				END IF;
			END IF;

			v_sps_end_dttm := get_sps_end_dttm(TO_DATE(v_sps_start_dttm, 'YYYYMMDDHH24MISS') , v_protocol_key);

			/*v_msps_key := sp_msps.lookup_key(v_sps_id);
			IF v_msps_key IS NULL THEN
				v_msps_key := sp_msps.lookup_key(v_study_key, v_protocol_key);
			END IF;*/ -- #63955

			IF v_count = v_index THEN
				dbms_output.put_line('1. v_msps_key=' || v_msps_key );
				IF v_msps_key IS NULL THEN
					v_msps_key := sp_msps.addnew
					(
						v_study_key, v_station_key, NULL, v_protocol_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), 
						v_sps_end_dttm, NULL, NULL, NULL
					);

				ELSE
					--raise_application_error (-20001, 'msps_key already exists (key=' || v_msps_key || ')');
					sp_msps.modify
					(
						v_msps_key, v_study_key, v_station_key, NULL, v_protocol_key,
						NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), v_sps_end_dttm, NULL, NULL, NULL
					);

				END IF;
				dbms_output.put_line('2. v_msps_key=' || v_msps_key );

				SELECT visit_key INTO v_visit_key 
				FROM iorder 
				WHERE order_key = sp_study.lookup_order_key(v_study_key);

			-- set scheduled status
				dbms_output.put_line('3. schelduled (v_visit_key=' || v_visit_key || ')');
				sp_msps.set_msps_stat(v_msps_key, 'S');
				sp_visit.schedule_admit(v_visit_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE));
				sp_visit.schedule_discharge(v_visit_key, v_sps_end_dttm);
			-- set mspsinfo (scheduled)
				SELECT	u.user_key, u.user_name, u.alias_name INTO	v_user_key, v_user_name, v_user_alias_name
				FROM	study s, iorder i, users u
				WHERE	s.study_key = v_study_key
				AND		s.order_key = i.order_key
				AND		i.refer_doctor_key = u.user_key;
				v_info_value := 'N' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_msps.set_msps_info(v_msps_key, 'RESCHEDULE1', v_info_value);

			-- set arrived status
				dbms_output.put_line('4. arrived (v_visit_key=' || v_visit_key || ',v_order_stat=' || v_order_stat || ')');
				sp_msps.set_msps_stat(v_msps_key, 'A');
				sp_visit.admit(v_visit_key, SYSDATE);
			-- set mspsinfo (arrived)
				v_info_value := 'A' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_msps.set_msps_info(v_msps_key, 'ARRIVE', v_info_value);

			END IF;

			v_count := v_count + 1;

		END LOOP;
		CLOSE cv_protocol;

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		v_report_key					report.report_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_creator_key					NUMBER;
		v_transcriber_key				NUMBER;
		v_reviser_key					NUMBER;
		v_approver_key					NUMBER;
		v_creator_id2					VARCHAR2(64);
		v_new_report_text				LONG;
		v_report_offset					NUMBER;
		v_report_text_lob				report.report_text_lob%TYPE;
		v_study_stat					study.study_stat%TYPE;

	BEGIN
	--  check required parameter
		IF v_event_type != 'ORU^R01' THEN
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;
		IF v_accession_no IS NULL THEN
			raise_application_error (-20001, 'access_no is NULL (obr-3)');
		END IF;
		IF v_approver_id IS NULL THEN
			raise_application_error (-20001, 'approver id is NULL (obr-32)');
		END IF;
		IF v_report_stat IS NULL THEN
			raise_application_error (-20001, 'report stat is NULL (obr-25)');
		END IF;
		IF v_report_control_id IS NULL THEN
			raise_application_error (-20001, 'report control id is NULL (xslt)');
		END IF;
		IF v_creator_id IS NULL THEN
			--raise_application_error (-20001, 'creator id is NULL (obr-16)');
			v_creator_id2 := v_approver_id;
		ELSE
			v_creator_id2 := v_creator_id;
		END IF;
		IF v_report_text IS NULL THEN
			raise_application_error (-20001, 'report text is NULL (obx-5)');
		END IF;
		IF v_report_control_id != 'NM' THEN		-- check report control id
			raise_application_error (-20001, 'there is not normal report (xslt)');
		END IF;
		/*
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_create_dttm IS NULL THEN
			raise_application_error (-20001, 'create dttm is NULL (orc-9)');
		END IF;
		IF v_approve_dttm IS NULL THEN
			raise_application_error (-20001, 'approve dttm is NULL (orc-9)');
		END IF;
		*/
	--  check required parameter

		IF v_put_report_type = 'INA' THEN -- INA
		
			--v_study_key := sp_study.lookup_key_acn(v_accession_no);
			v_study_key := lookup_study_key_for_report_2(v_accession_no);

			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found (acn=' || v_accession_no || ')');
			END IF;

			v_approver_key := sp_user.lookup_key(v_approver_id);
			v_creator_key := sp_user.lookup_key(v_creator_id2);

			IF v_report_stat = 230 THEN	-- Transcribed
					
				IF v_IsFirstReport = 'TRUE' THEN
					
					v_report_key := sp_report.find_ex(v_study_key);
					-- report_buffer_lob only
					sp_report.set_report_text(v_report_key, v_report_text, FALSE);
					sp_study.set_study_status(v_study_key, 230);
				
				ELSIF v_IsFirstReport = 'FALSE' THEN
					
					v_report_key := sp_report.lookup_last_report_key(v_study_key);
					-- Prelim(or Draft)Report that longer then 4000 characters
					-- Get an existing data from report_buffer_lob
					v_report_text_lob := sp_report.lookup_report_text_lob(v_report_key, FALSE);
					v_new_report_text := v_report_text_lob || v_report_text;
					sp_report.set_report_text(v_report_key, v_new_report_text, FALSE);
				
				END IF;
			
			ELSIF v_report_stat = 240 THEN	-- Approved
					
				IF v_IsFirstReport = 'TRUE' THEN
					
					v_report_key := sp_report.find_ex(v_study_key);
					-- Remove an exisiting report
					sp_report.unfinalize(v_report_key);
					-- report_text_lob only
					sp_report.set_report_text(v_report_key, v_report_text, FALSE);	-- ����Ʈ ���
					-- Leave report_text_lob only and purge report_buffer_lob
					sp_report.finalize(v_report_key);
					sp_study.set_study_status(v_study_key, 240);
				
				ELSIF v_IsFirstReport = 'FALSE' THEN	-- Always append if the value comes with False regardelss of length
					v_report_key := sp_report.lookup_last_report_key(v_study_key);
					-- Get an exisiting final report from report_text_lob
					v_report_text_lob := sp_report.lookup_report_text_lob(v_report_key, TRUE);
					v_new_report_text := v_report_text_lob || v_report_text;
					-- Append						
					sp_report.set_report_text(v_report_key, v_new_report_text, TRUE);
				
				END IF;
					
			ELSIF v_report_stat = 340 THEN	-- Addendum_Approved
				
				IF v_IsFirstReport = 'TRUE' THEN
					
					-- v_report_key := sp_report.find_addendum(v_study_key);
					-- IF v_report_key ='0' THEN
					 v_report_key := sp_report.addnew_addendum(v_study_key);
					-- END IF;
					-- Remove an exsiting report
					sp_report.unfinalize(v_report_key);
					sp_report.set_report_text(v_report_key, v_report_text, TRUE);
					sp_report.finalize(v_report_key);

					-- [#82764] 20180828 by khchoi 
					sp_study.set_addendum_status(v_study_key, 340, TRUE);					
					
				ELSIF v_IsFirstReport = 'FALSE' THEN	-- Always append if the value comes with False regardelss of length
					
					v_report_key := sp_report.lookup_last_report_key(v_study_key);
					-- Get an exisiting final report from report_text_lob
					v_report_text_lob := sp_report.lookup_report_text_lob(v_report_key, TRUE);
					v_new_report_text := v_report_text_lob || v_report_text;					
					-- Append
					sp_report.set_report_text(v_report_key, v_new_report_text, TRUE);
					
				END IF;

			END IF;
		
		ELSE -- General
		
			v_study_key := lookup_study_key_for_report_2(v_accession_no);	
			
			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found (acn=' || v_accession_no || ')');
			END IF;
			
			v_report_key := sp_report.find(v_study_key);
			
			IF ( v_report_key = 0 ) THEN
				v_report_key := sp_report.addnew(v_study_key);
				sp_report.set_report_text(v_report_key, v_report_text, FALSE);
			ELSE							
				v_report_key := sp_report.addnew_addendum(v_study_key);				
				sp_report.set_report_text(v_report_key, v_report_text, FALSE);
			END IF;
			
			sp_report.set_creator(v_report_key, v_creator_key, NVL(sp_util.to_dttm(SUBSTR(v_create_dttm, 1, 8), SUBSTR(v_create_dttm, 9, 6)), SYSDATE));
			sp_study.set_study_status2(v_study_key, 230, FALSE);
			
			IF v_report_stat = '240' OR v_report_stat = '340' THEN
				sp_report.set_approver(v_report_key, v_approver_key, NVL(sp_util.to_dttm(SUBSTR(v_approve_dttm, 1, 8), SUBSTR(v_approve_dttm, 9, 6)), SYSDATE));
				sp_report.approve(v_report_key, v_approver_key);
			END IF;
		
		END IF;
		
		-- If HL7ROUTEITEM inserted by ORU inbound(TRIGGER st_study_updated01), delete row
		
		DELETE hl7routeitem
		WHERE study_key = v_study_key
		AND route_stat = 'N'
		AND message_type = 'ORU'
		AND event_type = 'R01'
		AND object_key = v_report_key;

		RETURN v_report_key;
	END;

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
	RETURN NUMBER
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patient_birth_dttm_temp		VARCHAR2(14);
		v_patient_id_issuer				VARCHAR2(32);

	BEGIN
	--  check required parameter
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_patient_id_issuer_code IS NULL OR v_patient_id_issuer_code = '' THEN
			raise_application_error (-20001, 'patient id issuer is NULL (pid-3.4)');
			/*
			IF v_institution_code IS NOT NULL THEN
				v_patient_id_issuer := get_issuer_code(v_institution_code);
			ELSE
				v_patient_id_issuer := get_issuer_code(get_institution_code);
			END IF;
			*/
		ELSE
			v_patient_id_issuer := v_patient_id_issuer_code;
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL (pid-5)');
		END IF;
		IF v_last_name IS NULL THEN
			raise_application_error (-20001, 'last_name is NULL (pid-5.1)');
		END IF;
		IF v_patient_birth_dttm IS NULL THEN
			raise_application_error (-20001, 'patient birth dttm is NULL (pid-7)');
			--v_patient_birth_dttm_temp := TO_CHAR(SYSDATE, 'YYYYMMDD');
		ELSE
			v_patient_birth_dttm_temp := v_patient_birth_dttm;
		END IF;
		/*
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'patient location is NULL (pv1-2)');
		END IF;
		IF v_patient_sex IS NULL THEN
			raise_application_error (-20001, 'patient sex is NULL (pid-8)');
		END IF;
		IF v_race_code IS NULL THEN
			raise_application_error (-20001, 'race code is NULL (pid-10)');
		END IF;
		IF v_address IS NULL THEN
			raise_application_error (-20001, 'patient address is NULL (pid-11)');
		END IF;
		IF sp_codedict.exists_code ('TBL0005', v_race_code, 'HL7') = 0 THEN
			raise_application_error (-20001, 'not exists race-code(context_id=TBL0005,scheme=HL7) in codedict table');
		END IF;
		*/
	--  check required parameter

		IF v_event_type = 'ADT^A01' THEN
			v_patient_key := adt_a01
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A03' THEN
			v_patient_key := adt_a03
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A04' THEN
			v_patient_key := adt_a04
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A08' THEN
			v_patient_key := adt_a08
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A28' THEN
			v_patient_key := adt_a28
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A31' THEN
			v_patient_key := adt_a31
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				v_last_name, v_first_name, v_middle_name, v_prefix, v_suffix, 
				v_marital_stat, v_confidentiality, v_patient_birth_dttm_temp, sp_util.to_dttm(SUBSTR(v_patient_death_dttm,1,8)), v_patient_sex, 
				v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh, v_email, 
				v_race_code, v_phone_no, v_patient_stat, v_account_no, v_contact_type, 
				v_fax_no, v_address, v_city, v_state, v_country, 
				v_zipcode, v_visit_number, v_visit_stat, v_admit_dttm, v_discharge_dttm, 
				v_patient_location, v_patient_residence, v_refer_doctor_id, v_consult_doctor_id, v_ethnic_group, 
				v_home_phone_no, v_busi_phone_no
			);

		ELSIF v_event_type = 'ADT^A30' OR v_event_type = 'ADT^A40' THEN
			v_patient_key := adt_a40 (v_event_type, v_patient_id, v_prior_patient_id, v_patient_id_issuer);
		ELSIF v_event_type = 'ADT^A11' OR v_event_type = 'ADT^A38' THEN   -- cancel admit.
			v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		ELSE
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN NUMBER
	IS
		v_order_key						iorder.order_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_patient_key					patient.patient_key%TYPE;
		v_procplan_key					procplan.procplan_key%TYPE;
		v_order_doctor_key				NUMBER;
		v_refer_doctor_key				NUMBER;
		v_access_no1					NUMBER;
		v_filler_order_id1				NUMBER;
		v_visit_key						visit.visit_key%TYPE;
		v_refer_doctor_id2				VARCHAR2(32);
		v_accession_no_opid				VARCHAR2(32);

		v_new_study_instance_uid		VARCHAR2(64);
		v_patient_id_issuer				VARCHAR2(32);

		v_info_value					VARCHAR2(4000);
		v_user_name						users.user_name%TYPE;
		v_user_alias_name				users.alias_name%TYPE;
		v_diag_key						diagcode.diag_key%TYPE;
		v_studydiag_exist				NUMBER;

	BEGIN
	--  check required parameter
		IF v_event_type != 'ORM^O01' AND v_event_type != 'OMG^O19' AND v_event_type != 'OMI^O23' THEN
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_patient_id_issuer_code IS NULL OR v_patient_id_issuer_code = '' THEN
			raise_application_error (-20001, 'patient id issuer is NULL (pid-3.4)');
			--v_patient_id_issuer := get_issuer_code(get_institution_code);
		ELSE
			v_patient_id_issuer := v_patient_id_issuer_code;
		END IF;		
		IF v_order_control_id IS NULL THEN
			raise_application_error (-20001, 'order control id is NULL (orc-1)');
		END IF;
		IF v_patient_location IS NULL THEN
			raise_application_error (-20001, 'patient location is NULL (pv1-2)');
		END IF;
		IF v_placer_order_id IS NULL THEN
			raise_application_error (-20001, 'placer order id is NULL (orc-2, obr-2)');
		END IF;
		IF v_order_doctor_id IS NULL THEN
			raise_application_error (-20001, 'order doctor id is NULL (orc-12)');
		END IF;
		IF v_refer_doctor_id IS NULL THEN
			--raise_application_error (-20001, 'refer doctor id is NULL (pv1-8)');
			v_refer_doctor_id2 := v_order_doctor_id;
		ELSE
			v_refer_doctor_id2 := v_refer_doctor_id;
		END IF;
		IF v_order_department IS NULL THEN
			raise_application_error (-20001, 'order department is NULL (orc-17)');
		END IF;
		IF v_reqproc_code_value IS NULL THEN
			raise_application_error (-20001, 'requested procedure code value is NULL (obr-4.1)');
		END IF;
		IF v_reqproc_code_scheme IS NULL THEN
			raise_application_error (-20001, 'requested procedure code scheme is NULL (obr-4.3)');
		END IF;
		IF v_access_no IS NULL THEN
			raise_application_error (-20001, 'accession number is NULL (obr-18)');
		END IF;
		/*
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL (pid-5)');
		END IF;
		IF v_last_name IS NULL THEN
			raise_application_error (-20001, 'last_name is NULL (pid-5.1)');
		END IF;
		IF v_order_entry_user_id IS NULL THEN
			raise_application_error (-20001, 'order entry user id is NULL (orc-10)');
		END IF;
		IF v_order_callback_phone_no IS NULL THEN
			raise_application_error (-20001, 'order callback phone number is NULL (orc-14)');
		END IF;
		IF v_reqproc_reason IS NULL THEN
			raise_application_error (-20001, 'requested procedure reason is NULL (obr-31)');
		END IF;
		IF v_patient_birth_dttm IS NULL THEN
			raise_application_error (-20001, 'patient birth dttm is NULL (pid-7)');
		END IF;
		IF v_patient_sex IS NULL THEN
			raise_application_error (-20001, 'patient sex is NULL (pid-8)');
		END IF;
		IF v_order_stat = 'SC' THEN		-- check procedure scheduled
			IF sp_codedict.exists_code ('TBL0005', v_race_code, 'HL7') = 0 THEN
				raise_application_error (-20001, 'not exists race-code(context_id=TBL0005,scheme=HL7) in codedict table');
			END IF;
			IF v_address IS NULL THEN
				raise_application_error (-20001, 'patient address is NULL (pid-11)');
			END IF;
			IF v_consult_doctor_id IS NULL THEN
				raise_application_error (-20001, 'consult doctor id is NULL (pv1-9)');
			END IF;
			IF v_filler_order_id IS NULL THEN
				raise_application_error (-20001, 'filler order id is NULL (orc-3, obr-3)');
			END IF;
			IF v_order_entry_location IS NULL THEN
				raise_application_error (-20001, 'order entry location is NULL (orc-13)');
			END IF;
			IF v_reqproc_priority IS NULL THEN
				raise_application_error (-20001, 'priority is NULL (obr-5)');
			END IF;
			IF v_reqproc_id IS NULL THEN
				raise_application_error (-20001, 'requested procedure id is NULL (obr-19)');
			END IF;
			IF v_study_instance_uid IS NULL THEN
				raise_application_error (-20001, 'study instance uid is NULL (zds-1)');
			END IF;
			IF v_patient_arrange IS NULL THEN
				raise_application_error (-20001, 'transport arranged is NULL (obr-41)');
			END IF;
		END IF;
		*/
	--  check required parameter

		IF v_study_instance_uid IS NOT NULL AND sp_profile.get_boolean('ORDER', 'USE_THIRD_PARTY_WORKLIST_GATEWAY', 0) = 1 THEN
			IF LENGTH(v_study_instance_uid) <= 58 THEN
				v_new_study_instance_uid := v_study_instance_uid || '.99' || LPAD(ROUND(DBMS_RANDOM.VALUE(1,999)),3,0);
			ELSE
				v_new_study_instance_uid := v_study_instance_uid || '.98';
			END IF;
		ELSE
			v_new_study_instance_uid := v_study_instance_uid;
		END IF;

		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		IF v_patient_key IS NULL THEN
			raise_application_error (-20001, 'not found patient_key (pid=' || v_patient_id || ', idissuer=' || v_patient_id_issuer ||')');
			/*
			v_patient_key := put_patient
			(
				'ADT^A04', v_patient_id, NULL, v_patient_id_issuer, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix, 
				v_suffix, NULL, v_confidentiality, v_patient_birth_dttm, NULL, 
				v_patient_sex, NULL, NULL, NULL, NULL, 
				NULL, NULL, v_race_code, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, v_account_no, 'H', NULL, 
				NULL, NULL, v_address, NULL, NULL, 
				NULL, NULL, v_account_no, 'C', NULL, 
				NULL, v_patient_location, v_patient_residence, v_refer_doctor_id2, v_consult_doctor_id,
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL,'HL7-IHE'
			);
			*/
		END IF;

		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, v_reqproc_code_scheme);
		IF v_procplan_key IS NULL THEN
			raise_application_error (-20001, 'not found procplan_key (codevalue=' || v_reqproc_code_value || ', codescheme=' || v_reqproc_code_scheme ||')');
			--v_procplan_key := put_procplan_unmatched(v_reqproc_code_value, v_reqproc_code_scheme, v_reqproc_code_version, v_reqproc_code_meaning);
		END IF;

		v_refer_doctor_key := sp_user.lookup_key(v_refer_doctor_id2);
		IF v_refer_doctor_key IS NULL THEN
			raise_application_error (-20001, 'not found refer_doctor (id=' || v_refer_doctor_id2 || ')');
			--v_refer_doctor_key := put_user_unmatched(v_refer_doctor_id2, 20);
		END IF;

		v_order_doctor_key := sp_user.lookup_key(v_order_doctor_id);
		IF v_order_doctor_key IS NULL THEN
			raise_application_error (-20001, 'not found order_doctor (id=' || v_order_doctor_id || ')');
			--v_order_doctor_key := put_user_unmatched(v_order_doctor_id, 40);
		END IF;

		IF LENGTH(v_order_department) >= 16 THEN
			raise_application_error (-20001, 'too large value for department_code column (code=' || v_order_department || ')');
		END IF;

		IF sp_department.exists(v_order_department) = FALSE THEN
			raise_application_error (-20001, 'not exists order department code in department table (code=' || v_order_department || ')');
			--put_department_unmatched(v_order_department, v_order_department);
		END IF;

		v_order_key := sp_order.lookup_key(v_access_no);

		IF v_order_control_id = 'NW' THEN
			IF v_order_key IS NOT NULL THEN
				raise_application_error (-20001, 'accession number already exist. (acn=' || v_access_no || ')');
			END IF;

			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
				v_refer_doctor_key, NULL, NULL, NULL
			);
			IF v_account_no IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_account_no
				WHERE	visit_key = v_visit_key;
			END IF;

			v_order_key := sp_order.addnew
			(
				v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
				v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
				v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
			);
			-- set iorderinfo (ordered)
			SELECT	user_name, alias_name
			INTO	v_user_name, v_user_alias_name
			FROM	users
			WHERE	user_key = v_refer_doctor_key;
			v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
			sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

			v_study_key := sp_study.addnew
			(
				v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
				v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
			);

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'CA' THEN
			IF v_order_key IS NULL THEN
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
			END IF;
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
			END IF;

			IF v_access_no IS NULL THEN
				--v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
				v_study_key := sp_study.lookup_key_order(v_order_key);
			ELSE
				v_study_key := sp_study.lookup_key_acn(v_access_no);
			END IF;

			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found (acn=' || v_access_no || ')');
			END IF;

			sp_order.cancel(v_order_key, NULL);

			-- set studyinfo (canceled)
			SELECT	user_name, alias_name
			INTO	v_user_name, v_user_alias_name
			FROM	users
			WHERE	user_key = v_refer_doctor_key;
			v_info_value := 'C' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
			sp_study.set_study_info(v_study_key, 'CANCELED', v_info_value);

		ELSIF v_order_control_id = 'XO' THEN
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				/*
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);
				*/

			ELSE
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);
				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;

				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'SC' THEN
			IF v_order_key IS NULL THEN
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location, 
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);

			ELSE
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);
				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;
				
				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'DC' THEN
			RETURN -1;
		ELSE
			raise_application_error (-20001, 'found invalid order_control_id (id=' || v_order_control_id || ')');
		END IF;

		-- issuer 46099 20150407 khchoi 
		IF v_diagnosis_code IS NOT NULL THEN
			v_diag_key := sp_diagcode.put(v_diagnosis_code, 'ICD', '10CM', v_diagnosis_code_meaning);
			
			SELECT	COUNT(1)
			INTO	v_studydiag_exist
			FROM	DUAL
			WHERE	EXISTS
					(	SELECT	1
						FROM	studydiag
						WHERE 	study_key = v_study_key
						AND 	diag_key = v_diag_key
						AND 	diag_type = 'A'
					);
			
			IF v_studydiag_exist = 0 THEN
				sp_study.addnew_diagcode(v_study_key, v_diag_key);
			END IF;
			
		END IF;
		
		RETURN v_study_key;
	END;

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
	RETURN NUMBER
	IS
		v_procplan_key					procplan.procplan_key%TYPE;
		v_station_key					station.station_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;

	BEGIN
	--  check required parameter
		IF v_modality IS NULL THEN
			raise_application_error (-20001, 'not found modality (obr-24)');
		END IF;
		IF v_sps_start_dttm IS NULL THEN
			raise_application_error (-20001, 'not found sps start dttm (obr-27)');
		END IF;
		/*
		IF v_protcode_value IS NULL THEN
			raise_application_error (-20001, 'not found protcode value (obr-4.4)');
		END IF;
		IF v_protcode_scheme IS NULL THEN
			raise_application_error (-20001, 'not found protcode scheme (obr-4.6)');
		END IF;
		*/
	--  check required parameter

	-- lookup procplan
		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, v_reqproc_code_scheme);
		IF v_procplan_key IS NULL THEN
			raise_application_error (-20001, 'procplan_key not found (codevalue=' || v_reqproc_code_value || ', codescheme=' || v_reqproc_code_scheme ||')');
		END IF;

	-- lookup station
		v_station_key := lookup_station_key_by_modality(v_modality);
		IF v_station_key IS NULL THEN
			raise_application_error (-20001, 'station key not found (modcode=' || v_modality || ')');
		END IF;

		v_msps_key := put_msps_ex_hl7_ihe 
		(
			v_study_key, v_procplan_key, v_station_key, v_sps_id, v_modality, 
			v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index,
			v_order_control_id, v_order_stat
		);

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		CURSOR cv_protocol IS
			SELECT protocol_key
			FROM procplanprotocol
			WHERE procplan_key = v_procplan_key;

		v_protocol_key					protocol.protocol_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;
		v_count							NUMBER;
		v_sps_end_dttm					msps.sps_end_dttm%TYPE;
		v_visit_key						visit.visit_key%TYPE;

		v_user_key						users.user_key%TYPE;
		v_user_name						users.user_name%TYPE;
		v_user_alias_name				users.alias_name%TYPE;
		v_info_value					VARCHAR2(4000);

	BEGIN
		v_count := 1;

		OPEN cv_protocol;
		LOOP
			FETCH cv_protocol INTO v_protocol_key;
			IF cv_protocol%NOTFOUND THEN
				IF v_count = 1 THEN
					raise_application_error (-20001, 'not found protocol_key (procplan_key='|| v_procplan_key ||')');
				ELSE
					RETURN v_msps_key;
				END IF;
			END IF;

			v_sps_end_dttm := get_sps_end_dttm(TO_DATE(v_sps_start_dttm, 'YYYYMMDDHH24MISS') , v_protocol_key);

			v_msps_key := sp_msps.lookup_key(v_sps_id);
			IF v_msps_key IS NULL THEN
				v_msps_key := sp_msps.lookup_key(v_study_key, v_protocol_key);
			END IF;

			IF v_count = v_index THEN
				IF v_msps_key IS NULL THEN
					v_msps_key := sp_msps.addnew
					(
						v_study_key, v_station_key, NULL, v_protocol_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), 
						v_sps_end_dttm, NULL, NULL, NULL
					);

				ELSE
					--raise_application_error (-20001, 'msps_key already exists (key=' || v_msps_key || ')');
					sp_msps.modify
					(
						v_msps_key, v_study_key, v_station_key, NULL, v_protocol_key,
						NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), v_sps_end_dttm, NULL, NULL, NULL
					);

				END IF;

			-- set scheduled status
				dbms_output.put_line('3. schelduled (v_visit_key=' || v_visit_key || ')');
				sp_msps.set_msps_stat(v_msps_key, 'S');
				sp_visit.schedule_admit(v_visit_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE));
				sp_visit.schedule_discharge(v_visit_key, v_sps_end_dttm);
			-- set mspsinfo (scheduled)
				SELECT	u.user_key, u.user_name, u.alias_name INTO	v_user_key, v_user_name, v_user_alias_name
				FROM	study s, iorder i, users u
				WHERE	s.study_key = v_study_key
				AND		s.order_key = i.order_key
				AND		i.refer_doctor_key = u.user_key;
				v_info_value := 'N' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_msps.set_msps_info(v_msps_key, 'RESCHEDULE1', v_info_value);

			-- set arrived status
				IF v_order_stat <> 'SC' THEN
					dbms_output.put_line('4. arrived (v_visit_key=' || v_visit_key || ',v_order_stat=' || v_order_stat || ')');
					sp_msps.set_msps_stat(v_msps_key, 'A');
					sp_visit.admit(v_visit_key, SYSDATE);
				-- set mspsinfo (arrived)
					v_info_value := 'A' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
					sp_msps.set_msps_info(v_msps_key, 'ARRIVE', v_info_value);
				END IF;

			END IF;

			v_count := v_count + 1;

		END LOOP;
		CLOSE cv_protocol;

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		v_report_key					report.report_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_creator_key					NUMBER;
		v_transcriber_key				NUMBER;
		v_reviser_key					NUMBER;
		v_approver_key					NUMBER;
		v_creator_id2					VARCHAR2(64);
		v_new_report_text				LONG;
		v_report_offset					NUMBER;
		v_report_text_lob				report.report_text_lob%TYPE;
		v_study_stat					study.study_stat%TYPE;

	BEGIN
	--  check required parameter
		IF v_event_type != 'ORU^R01' THEN
			raise_application_error (-20001, 'found invalid event type (type=' || v_event_type || ')');
		END IF;
		IF v_accession_no IS NULL THEN
			raise_application_error (-20001, 'access_no is NULL (obr-3)');
		END IF;
		IF v_approver_id IS NULL THEN
			raise_application_error (-20001, 'approver id is NULL (obr-32)');
		END IF;
		IF v_report_stat IS NULL THEN
			raise_application_error (-20001, 'report stat is NULL (obr-25)');
		END IF;
		IF v_report_control_id IS NULL THEN
			raise_application_error (-20001, 'report control id (xslt)');
		END IF;
		IF v_creator_id IS NULL THEN
			--raise_application_error (-20001, 'creator id is NULL (obr-16)');
			v_creator_id2 := v_approver_id;
		ELSE
			v_creator_id2 := v_creator_id;
		END IF;
		IF v_report_text IS NULL THEN
			raise_application_error (-20001, 'report text is NULL (obx-5)');
		END IF;
		IF v_report_control_id != 'NM' THEN		-- check report control id
			raise_application_error (-20001, 'there is not normal report (xslt)');
		END IF;
		/*
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL (pid-3)');
		END IF;
		IF v_create_dttm IS NULL THEN
			raise_application_error (-20001, 'create dttm is NULL (orc-9)');
		END IF;
		IF v_approve_dttm IS NULL THEN
			raise_application_error (-20001, 'approve dttm is NULL (orc-9)');
		END IF;
		*/
	--  check required parameter

		v_report_key := sp_report.find(v_study_key);
			
		IF ( v_report_key = 0 ) THEN
			v_report_key := sp_report.addnew(v_study_key);
			sp_report.set_report_text(v_report_key, v_report_text, FALSE);
		ELSE							
			v_report_key := sp_report.addnew_addendum(v_study_key);				
			sp_report.set_report_text(v_report_key, v_report_text, FALSE);
		END IF;
		
		sp_report.set_creator(v_report_key, v_creator_key, NVL(sp_util.to_dttm(SUBSTR(v_create_dttm, 1, 8), SUBSTR(v_create_dttm, 9, 6)), SYSDATE));
		sp_study.set_study_status2(v_study_key, 230, FALSE);
		
		IF v_report_stat = '240' OR v_report_stat = '340' THEN
			sp_report.set_approver(v_report_key, v_approver_key, NVL(sp_util.to_dttm(SUBSTR(v_approve_dttm, 1, 8), SUBSTR(v_approve_dttm, 9, 6)), SYSDATE));
			sp_report.approve(v_report_key, v_approver_key);
		END IF;
		
		-- If HL7ROUTEITEM inserted by ORU inbound(TRIGGER st_study_updated01), delete row
		
		DELETE hl7routeitem
		WHERE study_key = v_study_key
		AND route_stat = 'N'
		AND message_type = 'ORU'
		AND event_type = 'R01'
		AND object_key = v_report_key;

		RETURN v_report_key;
	END;

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
	RETURN NUMBER
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patient_birth_dttm_temp		VARCHAR2(14);
		v_patient_id_issuer				VARCHAR2(32);
	BEGIN
	--  check required parameter
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL');
		END IF;
		IF v_patient_name IS NULL THEN
			raise_application_error (-20001, 'patient_name is NULL');
		END IF;
		IF v_patient_birth_dttm IS NULL THEN
			--raise_application_error (-20001, 'patient birth dttm is NULL');
			v_patient_birth_dttm_temp := TO_CHAR(SYSDATE, 'YYYYMMDD');
		ELSE
			v_patient_birth_dttm_temp := v_patient_birth_dttm;
		END IF;
		IF v_broker_aetitle IS NULL THEN
			v_patient_id_issuer := get_issuer_code(get_institution_code);
		ELSE
			v_patient_id_issuer := lookup_issuer_code(v_broker_aetitle);
		END IF;
		IF v_patient_id_issuer IS NULL THEN
			raise_application_error (-20001, 'not found patient id issuer');
		END IF;
	--  check required parameter

		IF v_event_type = 'ADT^A01' THEN
			v_patient_key := adt_a01
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				SUBSTR(v_patient_name,1,32), NULL, NULL, NULL, NULL,
				NULL, NULL,	v_patient_birth_dttm_temp, NULL, v_patient_sex,
				v_patient_size, v_patient_weight, NULL, NULL, v_email,
				NULL, v_tel_no, NULL, NULL, 'C',
				v_fax_no, v_address, NULL, NULL, NULL,
				v_zipcode, NULL, NULL, v_admit_dttm, v_discharge_dttm,
				v_current_location, v_current_residency, v_current_doctor_id, NULL, v_ethnic_group,
				v_tel_no, NULL
			);

		ELSIF v_event_type = 'ADT^A02' THEN
			v_patient_key := adt_a02(v_patient_id, v_patient_id_issuer, v_current_location, v_current_residency);

		ELSIF v_event_type = 'ADT^A03' THEN
			v_patient_key := adt_a03(v_patient_id, v_patient_id_issuer, v_current_location, v_current_residency);

		ELSIF v_event_type = 'ADT^A04' THEN
			v_patient_key := adt_a04
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				SUBSTR(v_patient_name,1,32), NULL, NULL, NULL, NULL,
				NULL, NULL,	v_patient_birth_dttm_temp, NULL, v_patient_sex,
				v_patient_size, v_patient_weight, NULL, NULL, v_email,
				NULL, v_tel_no, NULL, NULL, NULL,
				v_fax_no, v_address, NULL, NULL, NULL,
				v_zipcode, NULL, NULL, v_admit_dttm, v_discharge_dttm,
				v_current_location, v_current_residency, v_current_doctor_id, NULL, v_ethnic_group,
				v_tel_no, NULL
			);

		ELSIF v_event_type = 'ADT^A06' THEN
			v_patient_key := adt_a06(v_patient_id, v_patient_id_issuer, v_current_location, v_current_residency);

		ELSIF v_event_type = 'ADT^A07' THEN
			v_patient_key := adt_a07(v_patient_id, v_patient_id_issuer, v_current_location);

		ELSIF v_event_type = 'ADT^A08' THEN
			v_patient_key := adt_a08
			(
				v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
				SUBSTR(v_patient_name,1,32), NULL, NULL, NULL, NULL,
				NULL, NULL,	v_patient_birth_dttm_temp, NULL, v_patient_sex,
				v_patient_size, v_patient_weight, NULL, NULL, v_email,
				NULL, v_tel_no, NULL, NULL, NULL,
				v_fax_no, v_address, NULL, NULL, NULL,
				v_zipcode, NULL, NULL, v_admit_dttm, v_discharge_dttm,
				v_current_location, v_current_residency, v_current_doctor_id, NULL, v_ethnic_group,
				v_tel_no, NULL
			);

		ELSIF v_event_type = 'ADT^A18' THEN
			v_patient_key := adt_a18 (v_event_type, v_patient_id, v_prior_patient_id, v_patient_id_issuer);

		ELSIF v_event_type = 'ADT^A40' THEN
			v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
			dbms_output.put_line('v_patient_key=' || v_patient_key || '  v_patient_id=' || v_patient_id );

			IF v_patient_key IS NULL THEN
				v_patient_key := adt_a04
				(
					v_event_type, v_patient_id, v_patient_id_issuer, v_patient_ssn, v_patient_name,
					SUBSTR(v_patient_name,1,32), NULL, NULL, NULL, NULL,
					NULL, NULL,	v_patient_birth_dttm_temp, NULL, v_patient_sex,
					v_patient_size, v_patient_weight, NULL, NULL, v_email,
					NULL, v_tel_no, NULL, NULL, NULL,
					v_fax_no, v_address, NULL, NULL, NULL,
					v_zipcode, NULL, NULL, v_admit_dttm, v_discharge_dttm,
					v_current_location, v_current_residency, v_current_doctor_id, NULL, v_ethnic_group,
					v_tel_no, NULL
				);
				dbms_output.put_line('v_patient_key2=' || v_patient_key);

			END IF;
			dbms_output.put_line('v_patient_id=' || v_patient_id || '  v_prior_patient_id=' || v_prior_patient_id );

			v_patient_key := adt_a40 (v_event_type, v_patient_id, sp_util.parse_string(v_prior_patient_id, '^', 1), v_patient_id_issuer);

		ELSE
			v_patient_key := -1;

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN NUMBER
	IS
		v_order_key						iorder.order_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_patient_key					patient.patient_key%TYPE;
		v_procplan_key					procplan.procplan_key%TYPE;
		v_order_doctor_key				NUMBER;
		v_refer_doctor_key				NUMBER;
		v_attend_doctor_key				NUMBER;
		v_consult_doctor_key			NUMBER;
		v_perform_doctor_key			NUMBER;
		v_visit_key						visit.visit_key%TYPE;
		v_refer_doctor_id2				VARCHAR2(32);
		v_default_code_scheme			VARCHAR2(32);

		v_patient_id_issuer				VARCHAR2(32);
		v_new_study_instance_uid		VARCHAR2(64);

		v_info_value					VARCHAR2(4000);
		v_user_name						users.user_name%TYPE;
		v_user_alias_name				users.alias_name%TYPE;

	BEGIN

	--  check required parameter
		IF v_patient_id IS NULL THEN
			raise_application_error (-20001, 'patient id is NULL');
		END IF;
		IF v_order_control_id IS NULL THEN
			raise_application_error (-20001, 'order control id is NULL');
		END IF;
		IF v_refer_doctor_id IS NULL THEN
			v_refer_doctor_id2 := v_order_doctor_id;
		ELSE
			v_refer_doctor_id2 := v_refer_doctor_id;
		END IF;
		IF v_refer_doctor_id2 IS NULL THEN
			raise_application_error (-20001, 'refer doctor id is NULL');
		END IF;
		IF v_reqproc_code_value IS NULL THEN
			raise_application_error (-20001, 'requested procedure code value is NULL');
		END IF;
		IF v_access_no IS NULL THEN
			raise_application_error (-20001, 'accession number is NULL');
		END IF;
		IF v_broker_aetitle IS NULL THEN
			v_patient_id_issuer := get_issuer_code(get_institution_code);
		ELSE
			v_patient_id_issuer := lookup_issuer_code(v_broker_aetitle);
		END IF;
		IF v_patient_id_issuer IS NULL THEN
			raise_application_error (-20001, 'not found patient id issuer');
		END IF;
	--  check required parameter

		v_default_code_scheme := get_institution_code(v_patient_id_issuer);

		IF v_study_instance_uid IS NOT NULL AND sp_profile.get_boolean('ORDER', 'USE_THIRD_PARTY_WORKLIST_GATEWAY', 0) = 1 THEN
			IF LENGTH(v_study_instance_uid) <= 58 THEN
				v_new_study_instance_uid := v_study_instance_uid || '.99' || LPAD(ROUND(DBMS_RANDOM.VALUE(1,999)),3,0);
			ELSE
				v_new_study_instance_uid := v_study_instance_uid || '.98';
			END IF;
		ELSE
			v_new_study_instance_uid := v_study_instance_uid;
		END IF;

		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		IF v_patient_key IS NULL THEN
			--raise_application_error (-20001, 'not found patient (pid=' || v_patient_id || ', idissuer=' || v_patient_id_issuer ||')');
			v_patient_key := put_patient
			(
				'ADT^A04', v_patient_id, NULL, v_patient_id_issuer, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix, 
				v_suffix, NULL, v_confidentiality, v_patient_birth_dttm, NULL, 
				v_patient_sex, v_patient_size, v_patient_weight, NULL, NULL, 
				NULL, NULL, v_race_code, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, v_account_no, 'H', NULL, 
				NULL, NULL, v_address, NULL, NULL, 
				NULL, NULL, v_account_no, 'C', NULL, 
				NULL, v_patient_location, v_patient_residence, v_refer_doctor_id2, v_consult_doctor_id,
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL,'ODBC'
			);
		END IF;

		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme));
		IF v_procplan_key IS NULL THEN
			--raise_application_error (-20001, 'not found procplan_key (codevalue=' || v_reqproc_code_value || ', codescheme=' || v_reqproc_code_scheme ||')');
			v_procplan_key := put_procplan_unmatched(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme), v_reqproc_code_version, v_reqproc_code_meaning, v_reqproc_desc);
		/*
		ELSE
			IF v_reqproc_desc IS NOT NULL THEN
				UPDATE procplan SET procplan_desc = v_reqproc_desc WHERE procplan_key = v_procplan_key;
			END IF;
		*/
		END IF;

		v_order_doctor_key := sp_user.lookup_key(v_order_doctor_id);
		IF v_order_doctor_key IS NULL THEN
			v_order_doctor_key := put_user_unmatched(v_order_doctor_id, 40);
		END IF;

		v_refer_doctor_key := sp_user.lookup_key(v_refer_doctor_id2);
		IF v_refer_doctor_key IS NULL THEN
			--raise_application_error (-20001, 'not found refer_doctor (id=' || v_refer_doctor_id2 || ')');
			v_refer_doctor_key := put_user_unmatched(v_refer_doctor_id2, 20);
		END IF;

		v_attend_doctor_key := sp_user.lookup_key(v_attend_doctor_id);
		IF v_attend_doctor_key IS NULL THEN
			v_attend_doctor_key := put_user_unmatched(v_attend_doctor_id, 20);
		END IF;

		v_consult_doctor_key := sp_user.lookup_key(v_consult_doctor_id);
		IF v_consult_doctor_key IS NULL THEN
			v_consult_doctor_key := put_user_unmatched(v_consult_doctor_id, 20);
		END IF;

		v_perform_doctor_key := sp_user.lookup_key(v_perform_doctor_id);
		IF v_perform_doctor_key IS NULL THEN
			v_perform_doctor_key := put_user_unmatched(v_perform_doctor_id, 20);
		END IF;

		IF LENGTH(v_order_department) >= 16 THEN
			raise_application_error (-20001, 'too large value for department_code column (code=' || v_order_department || ')');
		END IF;
		IF sp_department.exists(v_order_department) = FALSE THEN
			put_department_unmatched(v_order_department, v_order_department);
		END IF;

		v_order_key := sp_order.lookup_key(v_access_no);

		IF v_order_control_id = 'NW' THEN
			IF v_order_key IS NULL THEN
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location,
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);
				UPDATE	study
				SET		other_patient_name = v_other_patient_name
				WHERE	study_key = v_study_key;

			ELSE
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);
				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;

				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

		-- update account_no
			sp_study.update_account_no(v_study_key, v_account_no);

		-- update doctors
			update_doctor(v_study_key, v_refer_doctor_key, v_order_doctor_key, v_consult_doctor_key, v_attend_doctor_key, v_perform_doctor_key, NULL);

			IF v_diagnosis IS NOT NULL THEN
				UPDATE	study
				SET		diagnosis = SUBSTR(v_diagnosis,1,2048)
				WHERE	study_key = v_study_key;
			END IF;

		ELSIF v_order_control_id = 'CA' THEN
			IF v_order_key IS NULL THEN
				--raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
			END IF;
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
			END IF;

			IF v_access_no IS NULL THEN
				--v_order_key := sp_order.lookup_key_by_placer_id(v_placer_order_id);
				v_study_key := sp_study.lookup_key_order(v_order_key);
			ELSE
				v_study_key := sp_study.lookup_key_acn(v_access_no);
			END IF;

			IF v_study_key IS NULL THEN
				raise_application_error (-20001, 'relational study not found (acn=' || v_access_no || ')');
			END IF;

			sp_order.cancel(v_order_key, NULL);

			-- set studyinfo (canceled)
			SELECT	user_name, alias_name
			INTO	v_user_name, v_user_alias_name
			FROM	users
			WHERE	user_key = v_refer_doctor_key;
			v_info_value := 'C' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
			sp_study.set_study_info(v_study_key, 'CANCELED', v_info_value);

		ELSIF v_order_control_id = 'XO' THEN
			IF v_order_key IS NULL THEN
				raise_application_error (-20001, 'relational order not found (acn=' || v_access_no || ')');
				/*
				v_visit_key := sp_visit.addnew
				(
					v_patient_key, get_institution_code(v_patient_id_issuer), v_patient_location, v_patient_residence, NULL, 
					v_refer_doctor_key, NULL, NULL, NULL
				);
				IF v_account_no IS NOT NULL THEN
					UPDATE	visit
					SET		visit_no = v_account_no
					WHERE	visit_key = v_visit_key;
				END IF;

				v_order_key := sp_order.addnew
				(
					v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, v_order_comments,
					v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), v_order_entry_location,
					v_order_callback_phone_no, v_filler_order_id, NULL, NULL, sp_util.to_dttm(SUBSTR(v_order_dttm, 1, 14))
				);
				-- set iorderinfo (ordered)
				SELECT	user_name, alias_name
				INTO	v_user_name, v_user_alias_name
				FROM	users
				WHERE	user_key = v_refer_doctor_key;
				v_info_value := 'N' || '|' || v_refer_doctor_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_order.set_order_info(v_order_key, 'ORDERED', v_info_value);

				v_study_key := sp_study.addnew
				(
					v_order_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority,
					v_patient_arrange, v_patient_location, v_access_no, v_new_study_instance_uid
				);
				UPDATE	study
				SET		other_patient_name = v_other_patient_name
				WHERE	study_key = v_study_key;
				*/
			ELSE
				SELECT visit_key INTO v_visit_key FROM iorder WHERE order_key = v_order_key;

				sp_order.modify
				(
					v_order_key, v_patient_key, v_visit_key, v_placer_order_id, v_order_reason, 
					v_order_comments, v_order_doctor_key, v_refer_doctor_key, v_order_department, sp_user.lookup_key(v_order_entry_user_id), 
					v_order_entry_location, v_order_callback_phone_no, NULL, NULL
				);

				v_study_key := sp_study.lookup_key_acn(v_access_no);

				IF v_study_key IS NULL THEN
					raise_application_error (-20001, 'study key not found (acn=' || v_access_no || ')');
				END IF;

				sp_study.modify
				(
					v_study_key, v_procplan_key, v_reqproc_reason, v_reqproc_comments, v_reqproc_priority, 
					v_patient_arrange
				);

			END IF;

			sp_study.update_account_no(v_study_key, v_account_no);

		ELSIF v_order_control_id = 'DC' THEN
			RETURN -1;
		END IF;

		RETURN v_study_key;
	END;

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
	RETURN NUMBER
	IS
		v_procplan_key					procplan.procplan_key%TYPE;
		v_station_key					station.station_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;
		v_protocol_key					protocol.protocol_key%TYPE;

		v_procprotcnt					NUMBER;
		v_patient_id_issuer				VARCHAR2(32);
		v_default_code_scheme			VARCHAR2(32);
		v_institution_code				VARCHAR2(32);
		v_exists						BOOLEAN;

	BEGIN

	--  check required parameter
		IF v_modality IS NULL THEN
			raise_application_error (-20001, 'modality code is NULL (obr-24)');
		END IF;
		IF v_protcode_meaning IS NULL THEN
			raise_application_error (-20001, 'protcode meaning is NULL (obr-4.5)');
		END IF;
		/*
		IF v_sps_start_dttm IS NULL THEN
			raise_application_error (-20001, 'sps start dttm is NULL (obr-27)');
		END IF;
		*/
	--  check required parameter

		v_patient_id_issuer := sp_study.get_patient_id_issuer(v_study_key);
		IF v_patient_id_issuer IS NULL OR v_patient_id_issuer = '' THEN   
			v_patient_id_issuer := get_issuer_code(get_institution_code);
		END IF;

		v_default_code_scheme := get_institution_code(v_patient_id_issuer);
		v_institution_code := get_institution_code(v_patient_id_issuer);


	-- lookup modality
		v_exists := sp_modality.exists(v_modality);
		IF v_exists = FALSE THEN
			sp_modality.addnew(v_modality, v_modality, NULL);
		END IF;

	-- lookup procplan
		v_procplan_key := sp_procplan.lookup_key(v_reqproc_code_value, NVL(v_reqproc_code_scheme, v_default_code_scheme));
		IF v_procplan_key IS NULL THEN
			raise_application_error (-20001, 'procplan_key not found (codevalue=' || v_reqproc_code_value || ', codescheme=' || NVL(v_reqproc_code_scheme, v_default_code_scheme) ||')');
		END IF;

	-- lookup protocol
		v_protocol_key := lookup_protocol_key(v_protcode_meaning, v_modality);

	-- put protocol, procplanprotocol
		IF v_protocol_key IS NULL THEN
			v_protocol_key := sp_protocol.addnew(v_protcode_meaning, v_modality, NULL, NULL, NULL, NULL, NULL, NULL);
			sp_procplan.link_procplan_protocol(v_procplan_key, v_protocol_key);
		ELSE
			SELECT	COUNT(0) INTO v_procprotcnt FROM PROCPLANPROTOCOL
			 WHERE	procplan_key = v_procplan_key
			   AND	protocol_key = v_protocol_key;

			IF v_procprotcnt = 0 THEN
				sp_procplan.link_procplan_protocol(v_procplan_key, v_protocol_key);
			END IF;
		END IF;

	-- lookup station
		v_station_key := lookup_station_key_by_modality(v_modality);
		IF v_station_key IS NULL THEN
			--raise_application_error (-20001, 'station key not found (modcode=' || v_modality || ')');
			v_station_key := put_station_unmatched(v_modality, v_aetitle, v_institution_code);
		END IF;

		v_msps_key := put_msps_ex_odbc 
		(
			v_study_key, v_procplan_key, v_station_key, v_sps_id, v_modality, 
			v_sps_start_dttm, v_protcode_value, v_protcode_scheme, v_protcode_meaning, v_index
		);

		RETURN v_msps_key;

	END;

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
	RETURN NUMBER
	IS
		CURSOR cv_protocol IS
			SELECT	protocol_key
			  FROM	procplanprotocol
			 WHERE	procplan_key = v_procplan_key
			 ORDER BY protocol_key desc;

		v_protocol_key					protocol.protocol_key%TYPE;
		v_msps_key						msps.msps_key%TYPE;
		v_count							NUMBER;
		v_sps_end_dttm					msps.sps_end_dttm%TYPE;
		v_visit_key						visit.visit_key%TYPE;

		v_user_key						users.user_key%TYPE;
		v_user_name						users.user_name%TYPE;
		v_user_alias_name				users.alias_name%TYPE;
		v_info_value					VARCHAR2(4000);

	BEGIN
		v_count := 1;

		OPEN cv_protocol;
		LOOP
			FETCH cv_protocol INTO v_protocol_key;
			IF cv_protocol%NOTFOUND THEN
				IF v_count = 1 THEN
					raise_application_error (-20001, 'not found protocol_key (procplan_key='|| v_procplan_key ||')');
				ELSE
					RETURN v_msps_key;
				END IF;
			END IF;

			v_sps_end_dttm := get_sps_end_dttm(TO_DATE(v_sps_start_dttm, 'YYYYMMDDHH24MISS') , v_protocol_key);

			v_msps_key := sp_msps.lookup_key(v_sps_id);
			IF v_msps_key IS NULL THEN
				v_msps_key := sp_msps.lookup_key(v_study_key, v_protocol_key);
			END IF;

			IF v_count = v_index THEN
				dbms_output.put_line('1. v_msps_key=' || v_msps_key );
				IF v_msps_key IS NULL THEN
					v_msps_key := sp_msps.addnew
					(
						v_study_key, v_station_key, NULL, v_protocol_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), 
						v_sps_end_dttm, NULL, NULL, NULL
					);

				ELSE
					--raise_application_error (-20001, 'msps_key already exists (key=' || v_msps_key || ')');
					sp_msps.modify
					(
						v_msps_key, v_study_key, v_station_key, NULL, v_protocol_key,
						NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE), v_sps_end_dttm, NULL, NULL, NULL
					);

				END IF;
				dbms_output.put_line('2. v_msps_key=' || v_msps_key );

				SELECT	visit_key INTO v_visit_key
				FROM	iorder
				WHERE	order_key = sp_study.lookup_order_key(v_study_key);

			-- set scheduled status
				sp_msps.set_msps_stat(v_msps_key, 'S');
				sp_visit.schedule_admit(v_visit_key, NVL(sp_util.to_dttm(SUBSTR(v_sps_start_dttm, 1, 8), SUBSTR(v_sps_start_dttm, 9, 6)),SYSDATE));
				sp_visit.schedule_discharge(v_visit_key, v_sps_end_dttm);
			-- set mspsinfo (scheduled)
				SELECT	u.user_key, u.user_name, u.alias_name INTO	v_user_key, v_user_name, v_user_alias_name
				FROM	study s, iorder i, users u
				WHERE	s.study_key = v_study_key
				AND		s.order_key = i.order_key
				AND		i.refer_doctor_key = u.user_key;
				v_info_value := 'N' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_msps.set_msps_info(v_msps_key, 'RESCHEDULE1', v_info_value);

			-- set arrived status
				sp_msps.set_msps_stat(v_msps_key, 'A');
				sp_visit.admit(v_visit_key, SYSDATE);
			-- set mspsinfo (arrived)
				v_info_value := 'A' || '|' || v_user_key || '|' || v_user_name || '|' || v_user_alias_name || '|' || TO_CHAR(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') || '|' || '|';
				sp_msps.set_msps_info(v_msps_key, 'ARRIVE', v_info_value);

			END IF;

			v_count := v_count + 1;

		END LOOP;
		CLOSE cv_protocol;

		RETURN v_msps_key;
	END;

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
	RETURN NUMBER
	IS
		v_report_key					report.report_key%TYPE;
		v_study_key						study.study_key%TYPE;
		v_report_stat1					NUMBER;
		v_creator_key					NUMBER;
		v_transcriber_key				NUMBER;
		v_reviser_key					NUMBER;
		v_approver_key					NUMBER;
		v_creator_id2					VARCHAR2(64);

	BEGIN

	--  check required parameter
		IF v_accession_no IS NULL THEN
			raise_application_error (-20001, 'access_no is NULL');
		END IF;
		IF v_report_stat IS NULL THEN
			raise_application_error (-20001, 'report stat is NULL');
		END IF;
		IF v_approver_id IS NULL THEN
			raise_application_error (-20001, 'approver id is NULL');
		END IF;
		IF v_creator_id IS NULL THEN
			v_creator_id2 := v_approver_id;
		ELSE
			v_creator_id2 := v_creator_id;
		END IF;
		IF v_report_text IS NULL THEN
			raise_application_error (-20001, 'report text is NULL');
		END IF;
	--  check required parameter

		IF (v_report_stat = '240') OR (v_report_stat = 'F') THEN
			v_report_stat1 := 240;
		ELSIF (v_report_stat = '340') OR (v_report_stat = 'A') THEN
			v_report_stat1 := 340;
		ELSE
			v_report_stat1 := 230;
		END IF;

		--v_study_key := sp_study.lookup_key_acn(v_accession_no);
		v_study_key := lookup_study_key_for_report(v_accession_no);
		IF v_study_key IS NULL THEN
			raise_application_error (-20001, 'relational study not found (acn=' || v_accession_no || ')');
		END IF;

		--v_report_key := sp_report.find_ex(v_study_key);
		v_report_key := sp_report.find_ex2(v_study_key);

		v_approver_key := sp_user.lookup_key(v_approver_id);
		IF v_approver_key IS NULL THEN
			v_approver_key := put_user_unmatched(v_approver_id, 80);
		END IF;

		v_creator_key := sp_user.lookup_key(v_creator_id2);
		IF v_creator_key IS NULL THEN
			v_creator_key := put_user_unmatched(v_creator_id2, 80);
		END IF;

	-- insert report text
		IF v_report_key IS NOT NULL THEN
			sp_report.set_report_text(v_report_key, v_report_text, FALSE);
		END IF;

		sp_report.set_creator(v_report_key, v_creator_key, NVL(sp_util.to_dttm(SUBSTR(v_create_dttm, 1, 8), SUBSTR(v_create_dttm, 9, 6)), SYSDATE));
		sp_study.set_study_status2(v_study_key, 230, FALSE);

		IF v_report_stat1 = '240' OR v_report_stat1 = '340' THEN
			sp_report.set_approver(v_report_key, v_approver_key, NVL(sp_util.to_dttm(SUBSTR(v_approve_dttm, 1, 8), SUBSTR(v_approve_dttm, 9, 6)), SYSDATE));
			sp_report.approve(v_report_key, v_approver_key);
		END IF;
		
		-- If HL7ROUTEITEM inserted by ORU inbound(TRIGGER st_study_updated01), delete row
		
		DELETE hl7routeitem
		WHERE study_key = v_study_key
		AND route_stat = 'N'
		AND message_type = 'ORU'
		AND event_type = 'R01'
		AND object_key = v_report_key;

		RETURN v_report_key;
	END;

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
	)
	IS
		v_mwl							mwl%ROWTYPE;
	BEGIN
		v_mwl.character_set				:= v_character_set;				
		v_mwl.scheduled_aetitle			:= v_scheduled_aetitle;			
		v_mwl.scheduled_dttm			:= TO_DATE(v_scheduled_dttm, 'YYYYMMDDHH24MISS');			
		v_mwl.scheduled_modality		:= v_scheduled_modality;		
		v_mwl.scheduled_station			:= v_scheduled_station;			
		v_mwl.scheduled_location		:= v_scheduled_location;		
		v_mwl.scheduled_proc_id			:= v_scheduled_proc_id;			
		v_mwl.scheduled_proc_desc		:= v_scheduled_proc_desc;		
		v_mwl.scheduled_action_codes	:= v_scheduled_action_codes;	
		v_mwl.scheduled_proc_status		:= v_scheduled_proc_status;		
		v_mwl.premedication				:= v_premedication;				
		v_mwl.contrast_agent			:= v_contrast_agent;			
		v_mwl.requested_proc_id			:= v_requested_proc_id;			
		v_mwl.requested_proc_desc		:= v_requested_proc_desc;		
		v_mwl.requested_proc_codes		:= v_requested_proc_codes;		
		v_mwl.requested_proc_priority	:= v_requested_proc_priority;	
		v_mwl.requested_proc_reason		:= v_requested_proc_reason;		
		v_mwl.requested_proc_comments	:= v_requested_proc_comments;	
		v_mwl.study_instance_uid		:= v_study_instance_uid;		
		v_mwl.proc_placer_order_no		:= v_proc_placer_order_no;		
		v_mwl.proc_filler_order_no		:= v_proc_filler_order_no;		
		v_mwl.accession_no				:= v_accession_no;				
		v_mwl.attend_doctor				:= v_attend_doctor;				
		v_mwl.perform_doctor			:= v_perform_doctor;			
		v_mwl.consult_doctor			:= v_consult_doctor;			
		v_mwl.request_doctor			:= v_request_doctor;			
		v_mwl.refer_doctor				:= v_refer_doctor;				
		v_mwl.request_department		:= v_request_department;		
		v_mwl.imaging_request_reason	:= v_imaging_request_reason;	
		v_mwl.imaging_request_comments	:= v_imaging_request_comments;	
		v_mwl.imaging_request_dttm		:= TO_DATE(v_imaging_request_dttm, 'YYYYMMDDHH24MISS');		
		v_mwl.isr_placer_order_no		:= v_isr_placer_order_no;		
		v_mwl.isr_filler_order_no		:= v_isr_filler_order_no;		
		v_mwl.admission_id				:= v_admission_id;				
		v_mwl.patient_transport			:= v_patient_transport;			
		v_mwl.patient_location			:= v_patient_location;			
		v_mwl.patient_residency			:= v_patient_residency;			
		v_mwl.patient_name				:= v_patient_name;				
		v_mwl.patient_id				:= v_patient_id;				
		v_mwl.other_patient_name		:= v_other_patient_name;		
		v_mwl.other_patient_id			:= v_other_patient_id;			
		v_mwl.patient_birth_dttm		:= sp_util.to_dttm(v_patient_birth_dttm);
		v_mwl.patient_sex				:= v_patient_sex;				
		v_mwl.patient_weight			:= v_patient_weight;			
		v_mwl.patient_size				:= v_patient_size;				
		v_mwl.patient_state				:= v_patient_state;				
		v_mwl.confidentiality			:= v_confidentiality;			
		v_mwl.pregnancy_status			:= v_pregnancy_status;			
		v_mwl.medical_alerts			:= v_medical_alerts;			
		v_mwl.contrast_allergies		:= v_contrast_allergies;		
		v_mwl.special_needs				:= v_special_needs;				
		v_mwl.specialty					:= v_specialty;
		v_mwl.diagnosis					:= v_diagnosis;
		v_mwl.admit_dttm				:= TO_DATE(v_admit_dttm, 'YYYYMMDDHH24MISS');
		v_mwl.register_dttm				:= TO_DATE(v_register_dttm, 'YYYYMMDDHH24MISS');
		v_mwl.study_ssn					:= v_study_ssn;

		IF v_mwl.scheduled_proc_status != '0' OR v_mwl.scheduled_proc_status IS NULL THEN
			sp_worklist.put_mwl(v_mwl);
			UPDATE mwl
			SET validate_dttm = NULL
			WHERE study_instance_uid = v_mwl.study_instance_uid
			AND validate_dttm IS NULL;

		ELSE
			sp_worklist.remove_mwl(v_mwl.study_instance_uid);
			sp_study.set_study_status(sp_study.lookup_key_acn(v_mwl.accession_no), 0);

		END IF;

	END;

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
	)
	IS
		v_patient_key				NUMBER;
		v_mwl						mwl%ROWTYPE;
		v_tmp_mwl					mwl%ROWTYPE;
	
	BEGIN
		
		v_mwl.character_set				:=	v_character_set;				
		v_mwl.scheduled_aetitle			:=	v_scheduled_aetitle;			
		v_mwl.scheduled_dttm			:=	v_scheduled_dttm;			
		v_mwl.scheduled_modality		:=	v_scheduled_modality;		
		v_mwl.scheduled_station			:=	v_scheduled_station;			
		v_mwl.scheduled_location		:=	v_scheduled_location;		
		v_mwl.scheduled_proc_id			:=	v_scheduled_proc_id;			
		v_mwl.scheduled_proc_desc		:=	v_scheduled_proc_desc;		
		v_mwl.scheduled_action_codes	:=	v_scheduled_action_codes;	
		v_mwl.scheduled_proc_status		:=	v_scheduled_proc_status;		
		v_mwl.premedication				:=	v_premedication;				
		v_mwl.contrast_agent			:=	v_contrast_agent;			
		v_mwl.requested_proc_id			:=	v_requested_proc_id;			
		v_mwl.requested_proc_desc		:=	v_requested_proc_desc;		
		v_mwl.requested_proc_codes		:=	v_requested_proc_codes;		
		v_mwl.requested_proc_priority	:=	v_requested_proc_priority;	
		v_mwl.requested_proc_reason		:=	v_requested_proc_reason;				
		v_mwl.requested_proc_comments	:=	v_requested_proc_comments;	
		v_mwl.study_instance_uid		:=	v_study_instance_uid;		
		v_mwl.proc_placer_order_no		:=	v_proc_placer_order_no;		
		v_mwl.proc_filler_order_no		:=	v_proc_filler_order_no;		
		v_mwl.accession_no				:=	v_accession_no;				
		v_mwl.attend_doctor				:=	v_attend_doctor;				
		v_mwl.perform_doctor			:=	v_perform_doctor;			
		v_mwl.consult_doctor			:=	v_consult_doctor;			
		v_mwl.request_doctor			:=	v_request_doctor;			
		v_mwl.refer_doctor				:=	v_refer_doctor;				
		v_mwl.request_department		:=	v_request_department;		
		v_mwl.imaging_request_reason	:=	v_imaging_request_reason;	
		v_mwl.imaging_request_comments	:=	v_imaging_request_comments;	
		v_mwl.imaging_request_dttm		:=	v_imaging_request_dttm;		
		v_mwl.isr_placer_order_no		:=	v_isr_placer_order_no;		
		v_mwl.isr_filler_order_no		:=	v_isr_filler_order_no;		
		v_mwl.admission_id				:=	v_admission_id;				
		v_mwl.patient_transport			:=	v_patient_transport;			
		v_mwl.patient_location			:=	v_patient_location;			
		v_mwl.patient_residency			:=	v_patient_residency;		
		v_mwl.patient_name				:=	v_patient_name;				
		v_mwl.patient_id				:=	v_patient_id;				
		v_mwl.other_patient_name		:=	v_other_patient_name;		
		v_mwl.other_patient_id			:=	v_other_patient_id;			
		v_mwl.patient_birth_dttm		:=	v_patient_birth_dttm;		
		v_mwl.patient_sex				:=	v_patient_sex;				
		v_mwl.patient_weight			:=	v_patient_weight;			
		v_mwl.patient_size				:=	v_patient_size;				
		v_mwl.patient_state				:=	v_patient_state;				
		v_mwl.confidentiality			:=	v_confidentiality;			
		v_mwl.pregnancy_status			:=	v_pregnancy_status;			
		v_mwl.medical_alerts			:=	v_medical_alerts;			
		v_mwl.contrast_allergies		:=	v_contrast_allergies;		
		v_mwl.special_needs				:=	v_special_needs;				
		v_mwl.specialty					:=	v_specialty;					
		v_mwl.diagnosis					:=	v_diagnosis;					
		v_mwl.admit_dttm				:=	v_admit_dttm;
		v_mwl.register_dttm				:=	v_register_dttm;
		v_mwl.study_ssn					:=	v_study_ssn;

		IF v_order_control_id = 'NW' THEN
			IF sp_worklist.exists_mwl(v_mwl.study_instance_uid) > 0 THEN
			
				sp_worklist.lookup_mwl(v_mwl.study_instance_uid, v_tmp_mwl);
			
				v_tmp_mwl.scheduled_action_codes := v_mwl.scheduled_action_codes;
				v_tmp_mwl.requested_proc_codes := v_mwl.requested_proc_codes;
			
			ELSE
				v_tmp_mwl := v_mwl;

			END IF;

			v_patient_key := sp_patient.lookup_key(v_tmp_mwl.patient_id);
			
			IF v_patient_key IS NULL THEN
				v_patient_key := sp_patient.addnew(v_tmp_mwl.patient_id, v_tmp_mwl.patient_name, NULL, NULL,
						v_tmp_mwl.patient_birth_dttm, v_tmp_mwl.patient_sex, NULL, NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL, NULL, v_tmp_mwl.patient_location, v_tmp_mwl.patient_residency, NULL, NULL);
			END IF;
			
			sp_worklist.put_mwl(v_tmp_mwl);
		
		ELSIF v_order_control_id = 'CA' THEN	-- cancel order
			sp_worklist.remove_mwl(v_mwl.study_instance_uid);

		ELSIF v_order_control_id = 'XO' THEN	-- change order
			sp_worklist.lookup_mwl(v_mwl.study_instance_uid, v_tmp_mwl);
		
			sp_util.update_date(v_tmp_mwl.scheduled_dttm,	v_mwl.scheduled_dttm);
			sp_util.update_string(v_tmp_mwl.scheduled_modality,	v_mwl.scheduled_modality);
			sp_util.update_string(v_tmp_mwl.scheduled_station, v_mwl.scheduled_station);
			sp_util.update_string(v_tmp_mwl.scheduled_proc_id, v_mwl.scheduled_proc_id);
			sp_util.update_string(v_tmp_mwl.scheduled_proc_desc, v_mwl.scheduled_proc_desc);
			sp_util.update_string(v_tmp_mwl.scheduled_action_codes,	v_mwl.scheduled_action_codes);
			sp_util.update_string(v_tmp_mwl.requested_proc_id, v_mwl.requested_proc_id);		
			sp_util.update_string(v_tmp_mwl.requested_proc_desc, v_mwl.requested_proc_desc);		
			sp_util.update_string(v_tmp_mwl.requested_proc_codes, v_mwl.requested_proc_codes);		
			sp_util.update_string(v_tmp_mwl.requested_proc_priority, v_mwl.requested_proc_priority);	
			sp_util.update_string(v_tmp_mwl.requested_proc_comments, v_mwl.requested_proc_comments);	
			sp_util.update_string(v_tmp_mwl.accession_no, v_mwl.accession_no);	
			sp_util.update_string(v_tmp_mwl.request_doctor,	v_mwl.request_doctor);			
			sp_util.update_string(v_tmp_mwl.refer_doctor, v_mwl.refer_doctor);		
			sp_util.update_string(v_tmp_mwl.request_department, v_mwl.request_department);		
			sp_util.update_string(v_tmp_mwl.imaging_request_reason,	v_mwl.imaging_request_reason);	
			sp_util.update_date(v_tmp_mwl.imaging_request_dttm, v_mwl.imaging_request_dttm);		
			sp_util.update_string(v_tmp_mwl.isr_placer_order_no, v_mwl.isr_placer_order_no);		
			sp_util.update_string(v_tmp_mwl.isr_filler_order_no, v_mwl.isr_filler_order_no);		
			sp_util.update_string(v_tmp_mwl.patient_transport, v_mwl.patient_transport);		

			sp_worklist.put_mwl(v_tmp_mwl);

		ELSIF v_order_control_id = 'DC' THEN	-- discontinue order
			sp_worklist.remove_mwl(v_mwl.study_instance_uid);
		
		END IF;

	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- visit
		-- admit (visit_stat = 'A')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;
			sp_visit.admit(v_visit_key, sp_util.to_dttm(SUBSTR(v_admit_dttm, 1, 8), SUBSTR(v_admit_dttm, 9, 6)));

		/*
		ELSE
		-- modify patient
			sp_patient.modify
			(
				v_patient_key, v_patient_ssn, v_last_name, v_first_name, v_middle_name,
				v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, v_patient_name,
				NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- modify patientcontact (contact_type = 'H')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, v_contact_type);
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
					v_city, v_state, v_zipcode, v_country, NULL
				);
			END IF;

		-- modify patientcontact (contact_type = 'O')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, 'O');
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;
			

		-- patient info update on study table (IHE PIR)
		-- [#85096] 20180830 by mryang
		sp_worklist.patient_info_update(v_patient_id, v_patient_name, v_patient_sex, v_patient_birth_dttm, v_patient_id_issuer_code);
		*/

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a02
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency	 			IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residency, NULL,
				NULL
			);

		-- admit (visit_stat = 'A')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residency, NULL, 
				NULL, NULL, NULL, NULL
			);
			sp_visit.admit(v_visit_key, SYSDATE);

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a03
	(
		v_patient_id		 			IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency	 			IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residency, NULL,
				NULL
			);

		-- discharge (visit_stat = 'D')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residency, NULL, 
				NULL, NULL, NULL, NULL
			);
			sp_visit.discharge(v_visit_key, SYSDATE);

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- discharge (visit_stat = 'D')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				NULL, NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;
			sp_visit.discharge(v_visit_key, SYSDATE);

		/*
		ELSE
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- admit (visit_stat = 'A')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;
			sp_visit.admit(v_visit_key, sp_util.to_dttm(SUBSTR(v_admit_dttm, 1, 8), SUBSTR(v_admit_dttm, 9, 6)));
		*/

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- admit (visit_stat = 'C')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;

		/*
		ELSE
		-- modify patient
			sp_patient.modify
			(
				v_patient_key, v_patient_ssn, v_last_name, v_first_name, v_middle_name,
				v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, v_patient_name,
				NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- modify patientcontact (contact_type = 'H')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, v_contact_type);
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
					v_city, v_state, v_zipcode, v_country, NULL
				);
			END IF;

		-- modify patientcontact (contact_type = 'O')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, 'O');
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;
			-- [#85096] 20180830 by mryang
			sp_worklist.patient_info_update(v_patient_id, v_patient_name, v_patient_sex, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_id_issuer_code);
		*/

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a06
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location				IN visit.patient_location%TYPE,
		v_patient_residency				IN visit.patient_residency%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residency, NULL,
				NULL
			);

		-- admit (visit_stat = 'A')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residency, NULL,
				NULL, NULL, NULL, NULL
			);
			sp_visit.admit(v_visit_key, SYSDATE);

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a07
	(
		v_patient_id					IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE,
		v_patient_location	 			IN visit.patient_location%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, NULL, NULL,
				NULL
			);

		-- discharge (visit_stat = 'D')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, NULL, NULL,
				NULL, NULL, NULL, NULL
			);
			sp_visit.discharge(v_visit_key, SYSDATE);
		-- created (visit_stat = 'C')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, NULL, NULL,
				NULL, NULL, NULL, NULL
			);

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- modify patient
			sp_patient.modify
			(
				v_patient_key, v_patient_ssn, v_last_name, v_first_name, v_middle_name,
				v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, v_patient_name,
				NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- modify patientcontact (contact_type = 'H')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, v_contact_type);
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
					v_city, v_state, v_zipcode, v_country, NULL
				);
			END IF;

		-- modify patientcontact (contact_type = 'O')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, 'O');
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- patient info update on study table (IHE PIR)
		-- [#85096] 20180830 by mryang
			sp_worklist.patient_info_update(v_patient_id, v_patient_name, v_patient_sex, v_patient_birth_dttm, v_patient_id_issuer_code);

		/*
		ELSE
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;
			
		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- visit
		-- created (visit_stat = 'C')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;
		*/

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a18
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN patient.patient_id%TYPE,
		v_prior_patient_id				IN patient.patient_id%TYPE,
		v_patient_id_issuer_code		IN patient.patient_id_issuer_code%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_merger_patient_key			patient.patient_key%TYPE;
		v_mergee_patient_key			patient.patient_key%TYPE;

	BEGIN
		v_merger_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);
		v_mergee_patient_key := sp_patient.lookup_key(v_prior_patient_id, v_patient_id_issuer_code);

		IF v_merger_patient_key IS NULL THEN
			RAISE_APPLICATION_ERROR(-20001, 'merger key not found (id=' || v_patient_id || ')');
		END IF;
		IF v_mergee_patient_key IS NULL THEN
			RAISE_APPLICATION_ERROR(-20001, 'mergee key not found (id=' || v_prior_patient_id || ')');
		END IF;

		sp_patient.merge(v_merger_patient_key, v_mergee_patient_key);

		RETURN v_merger_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;
		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;
		-- visit
		-- created (visit_stat = 'C')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;

		/*
		ELSE
		-- modify patient
			sp_patient.modify
			(
				v_patient_key, v_patient_ssn, v_last_name, v_first_name, v_middle_name,
				v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, v_patient_name,
				NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;
		-- modify patientcontact (contact_type = 'H')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, v_contact_type);
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
					v_city, v_state, v_zipcode, v_country, NULL
				);
			END IF;

		-- modify patientcontact (contact_type = 'O')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, 'O');
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;
		*/

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					patient.patient_key%TYPE;
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
		v_visit_key						visit.visit_key%TYPE;
		v_visit_no						visit.visit_no%TYPE;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN
		-- modify patient
			sp_patient.modify
			(
				v_patient_key, v_patient_ssn, v_last_name, v_first_name, v_middle_name,
				v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, v_patient_name,
				NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;

		-- modify patientcontact (contact_type = 'H')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, v_contact_type);
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
					v_city, v_state, v_zipcode, v_country, NULL
				);
			END IF;

		-- modify patientcontact (contact_type = 'O')
			v_patientcontact_key := lookup_patientcontact_key(v_patient_key, 'O');
			IF v_patientcontact_key IS NOT NULL THEN
				sp_patient.modify_contact
				(
					v_patientcontact_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		/*
		ELSE
		-- add new patient
			v_patient_key := sp_patient.addnew
			(
				v_patient_id, v_patient_id_issuer_code, v_patient_ssn, v_last_name, v_first_name,
				v_middle_name, v_prefix, v_suffix, sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)), v_patient_sex, 
				NULL, v_patient_name, NULL
			);
		-- update patient demographic
			sp_patient.set_demo
			(
				v_patient_key, v_marital_stat, v_confidentiality, v_patient_size, v_patient_weight,
				v_blood_type_abo, v_blood_type_rh, NULL, NULL, NULL,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'), NULL, v_ethnic_group
			);
		-- update medical info
			--sp_patient.set_medical();
		-- update contact info
			sp_patient.set_contact(v_patient_key, v_email, v_phone_no);
		-- update patient location
			sp_patient.update_location
			(
				v_patient_key, NULL, v_patient_location, v_patient_residence, NULL,
				NULL
			);
		-- update account number
			sp_patient.update_account_no(v_patient_key, v_account_no);
		-- check and update patient decease
			IF v_patient_death_dttm IS NOT NULL THEN
				sp_patient.decease(v_patient_key, sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)));
			END IF;
		-- add new patientcontact (contact_type = 'H')
			v_patientcontact_key := sp_patient.addnew_contact
			(
				v_patient_key, v_contact_type, v_home_phone_no, v_fax_no, v_address,
				v_city, v_state, v_zipcode, v_country, NULL
			);
		-- check and add new patientcontact (contact_type = 'O')
			IF v_busi_phone_no IS NOT NULL THEN
				v_patientcontact_key := sp_patient.addnew_contact
				(
					v_patient_key, 'O', v_busi_phone_no, NULL, NULL,
					NULL, NULL, NULL, NULL, NULL
				);
			END IF;

		-- visit
		-- created (visit_stat = 'C')
			v_visit_key := sp_visit.addnew
			(
				v_patient_key, get_institution_code(v_patient_id_issuer_code), v_patient_location, v_patient_residence, NULL, 
				sp_user.lookup_key(v_refer_doctor_id), NULL, NULL, NULL
			);
			IF v_visit_number IS NOT NULL THEN
				UPDATE	visit
				SET		visit_no = v_visit_number
				WHERE	visit_key = v_visit_key;
			END IF;
		*/

		END IF;

		RETURN v_patient_key;
	END;

	-------------------------------------------------------------------------------------------------
	FUNCTION adt_a40
	(
		v_event_type					IN VARCHAR2,
		v_patient_id					IN patient.patient_id%TYPE,
		v_prior_patient_id				IN patient.patient_id%TYPE,
		v_patient_id_issuer				IN patient.patient_id_issuer%TYPE
	)
	RETURN patient.patient_key%TYPE
	IS
		v_merger_patient_key			patient.patient_key%TYPE;
		v_mergee_patient_key			patient.patient_key%TYPE;

	BEGIN
		v_merger_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer);
		v_mergee_patient_key := sp_patient.lookup_key(v_prior_patient_id, v_patient_id_issuer);

		IF v_merger_patient_key IS NULL THEN
			RAISE_APPLICATION_ERROR(-20001, 'merger key not found (id=' || v_patient_id || ')');
		END IF;
		IF v_mergee_patient_key IS NULL THEN
			RAISE_APPLICATION_ERROR(-20001, 'mergee key not found (id=' || v_prior_patient_id || ')');
		END IF;

		sp_patient.merge(v_merger_patient_key, v_mergee_patient_key);

		RETURN v_merger_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no, patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, v_phone_no, v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);

			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= v_phone_no,
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no,
				patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
				v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);

			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NOT NULL THEN

			UPDATE	patient
			   SET	current_location		= 'O',
					current_residency		= NULL,
					current_ward			= NULL
			 WHERE	patient_key		= v_patient_key;

			IF v_visit_number <> 'C' THEN
					sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
					sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no,
				patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
				v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);

			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		END IF;

		RETURN v_patient_key;
	END;

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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no,
				patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
				v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);

			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

			/*SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact (patientcontact_key, patient_key, contact_type, phone_no, fax_no,
					address, city, state, country, zipcode)
			VALUES (v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
					v_address, v_city, v_state, v_country, v_zipcode);

			SELECT sq_visit.nextval INTO v_visit_key FROM dual;
			INSERT INTO visit (visit_key, patient_key, visit_no, visit_stat,
					admission_dttm, discharge_dttm, patient_location,
					patient_residency, refer_doctor_key) --, consult_doctor_key)
			VALUES (v_visit_key, v_patient_key, TO_CHAR(v_visit_key), 'C',
					sp_util.to_dttm(SUBSTR(v_admit_dttm, 1, 8), SUBSTR(v_admit_dttm, 9, 6)),
					sp_util.to_dttm(SUBSTR(v_discharge_dttm, 1, 8), SUBSTR(v_discharge_dttm, 9, 6)),
					v_patient_location,
					NULL, sp_user.lookup_key(v_refer_doctor_id));--,
					sp_user.lookup_key(v_consult_doctor_id);


			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
			-- then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/
		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			UPDATE	patientcontact
			   SET	phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					fax_no					= v_fax_no,
					address					= v_address,
					city					= v_city,
					state					= v_state,
					country					= v_country,
					zipcode					= v_zipcode
			 WHERE	patient_key		= v_patient_key
			   AND	contact_type	= 'H';


			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

			/* auto update by st_patient_updated trigger (2009/02/12)
			UPDATE study
			SET	patient_name		= v_patient_name2,
				patient_birth_dttm	= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm2, 1, 8))
			WHERE 	patient_id = v_patient_id
			AND   patient_id_issuer		= v_patient_id_issuer_code		-- changed 2009/02/10
			AND   validate_dttm is not NULL;							-- changed 2009/02/10

			UPDATE visit
			SET visit_no				= v_visit_number2,
				visit_stat			= v_visit_stat2,
			SET	patient_location		= v_patient_location2,
				refer_doctor_key		= sp_user.lookup_key(v_refer_doctor_id2)	--,
				consult_doctor_key		= sp_user.lookup_key(v_consult_doctor_id2)
			WHERE patient_key			= v_patient_key;

			-- put(addnew/modify) guarantor
				-- if not exist gtr

			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
		 then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/

		END IF;

		RETURN v_patient_key;
	END;
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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no,
				patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
				v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);


			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;
			/*SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact (patientcontact_key, patient_key, contact_type, phone_no, fax_no,
					address, city, state, country, zipcode)
			VALUES (v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
					v_address, v_city, v_state, v_country, v_zipcode);
			SELECT sq_visit.nextval INTO v_visit_key FROM dual;
			INSERT INTO visit (visit_key, patient_key, visit_no, visit_stat,
					admission_dttm, discharge_dttm, patient_location,
					patient_residency, refer_doctor_key)--, consult_doctor_key)
			VALUES (v_visit_key, v_patient_key, TO_CHAR(v_visit_key), 'C',
					sp_util.to_dttm(SUBSTR(v_admit_dttm, 1, 8), SUBSTR(v_admit_dttm, 9, 6)),
					sp_util.to_dttm(SUBSTR(v_discharge_dttm, 1, 8), SUBSTR(v_discharge_dttm, 9, 6)),
					v_patient_location,
					NULL, sp_user.lookup_key(v_refer_doctor_id));--,
					sp_user.lookup_key(v_consult_doctor_id);


			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
			-- then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/
		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			UPDATE	patientcontact
			   SET	phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					fax_no					= v_fax_no,
					address					= v_address,
					city					= v_city,
					state					= v_state,
					country					= v_country,
					zipcode					= v_zipcode
			 WHERE	patient_key		= v_patient_key
			   AND	contact_type	= 'H';

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

		/*	auto update by st_patient_updated trigger (2009/02/12)
			UPDATE study
			SET	patient_name		= v_patient_name2,
				patient_birth_dttm	= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm2, 1, 8))
			WHERE 	patient_id = v_patient_id
			AND   patient_id_issuer		= v_patient_id_issuer_code		-- changed 2009/02/10
			AND   validate_dttm is not NULL;							-- changed 2009/02/10
			UPDATE visit
			SET visit_no				= v_visit_number2,
				visit_stat			= v_visit_stat2,
			SET	patient_location		= v_patient_location2,
				refer_doctor_key		= sp_user.lookup_key(v_refer_doctor_id2)	--,
				consult_doctor_key		= sp_user.lookup_key(v_consult_doctor_id2)
			WHERE patient_key			= v_patient_key;

			-- put(addnew/modify) guarantor
				-- if not exist gtr

			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
		-- then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/

		END IF;

		RETURN v_patient_key;
	END;
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
	RETURN patient.patient_key%TYPE
	IS
		v_patient_key					NUMBER;
		v_patientcontact_key			NUMBER;
		v_visit_key						NUMBER;
		v_patientgrt_key				NUMBER;

	BEGIN
		v_patient_key := sp_patient.lookup_key(v_patient_id, v_patient_id_issuer_code);

		IF v_patient_key IS NULL THEN

			SELECT sq_patient.nextval INTO v_patient_key FROM dual;
			INSERT INTO patient
			(
				patient_key, patient_id, patient_id_issuer, patient_id_issuer_code, patient_ssn,
				patient_name, last_name, first_name, middle_name, prefix,
				suffix, marital_stat, confidentiality,
				patient_birth_dttm,
				patient_death_dttm,
				patient_sex, patient_size, patient_weight, blood_type_abo, blood_type_rh,
				race_code_key,
				email, phone_no,
				patient_stat, account_no, current_location,
				current_residency,
				current_ward,
				address
			)
			VALUES
			(
				v_patient_key, v_patient_id, v_patient_id_issuer_code, v_patient_id_issuer_code, v_patient_ssn,
				v_patient_name, v_last_name, v_first_name, v_middle_name, v_prefix,
				v_suffix, v_marital_stat, v_confidentiality,
				sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
				sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
				v_patient_sex, v_patient_size, v_patient_weight, v_blood_type_abo, v_blood_type_rh,
				sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
				v_email, SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
				v_patient_stat, v_account_no, v_patient_location,
				sp_util.parse_string(v_patient_residence, '^', 1),
				sp_util.parse_string(v_patient_residence, '^', 2),
				v_address
			);

			SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact
			(
				patientcontact_key, patient_key, contact_type, phone_no, fax_no,
				address, city, state, country, zipcode
			)
			VALUES
			(
				v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
				v_address, v_city, v_state, v_country, v_zipcode
			);

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

			/*SELECT sq_patientcontact.nextval INTO v_patientcontact_key FROM dual;
			INSERT INTO patientcontact (patientcontact_key, patient_key, contact_type, phone_no, fax_no,
					address, city, state, country, zipcode)
			VALUES (v_patientcontact_key, v_patient_key, v_contact_type, v_phone_no, v_fax_no,
					v_address, v_city, v_state, v_country, v_zipcode);

			SELECT sq_visit.nextval INTO v_visit_key FROM dual;
			INSERT INTO visit (visit_key, patient_key, visit_no, visit_stat,
					admission_dttm, discharge_dttm, patient_location,
					patient_residency, refer_doctor_key) --, consult_doctor_key)
			VALUES (v_visit_key, v_patient_key, TO_CHAR(v_visit_key), 'C',
					sp_util.to_dttm(SUBSTR(v_admit_dttm, 1, 8), SUBSTR(v_admit_dttm, 9, 6)),
					sp_util.to_dttm(SUBSTR(v_discharge_dttm, 1, 8), SUBSTR(v_discharge_dttm, 9, 6)),
					v_patient_location,
					NULL, sp_user.lookup_key(v_refer_doctor_id));--,
					sp_user.lookup_key(v_consult_doctor_id);


			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
			-- then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/
		ELSE

			UPDATE	patient
			   SET
					patient_ssn				= v_patient_ssn,
					patient_name			= v_patient_name,
					last_name				= v_last_name,
					first_name				= v_first_name,
					middle_name				= v_middle_name,
					prefix					= v_prefix,
					suffix					= v_suffix,
					patient_birth_dttm		= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm, 1, 8)),
					patient_death_dttm		= sp_util.to_dttm(SUBSTR(v_patient_death_dttm, 1, 8)),
					patient_sex				= v_patient_sex,
					patient_size			= v_patient_size,
					patient_weight			= v_patient_weight,
					blood_type_abo			= v_blood_type_abo,
					blood_type_rh			= v_blood_type_rh,
					race_code_key			= sp_codedict.lookup_code_key('TBL0005', v_race_code, 'HL7'),
					email					= v_email,
					phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					patient_stat			= v_patient_stat,
					account_no				= v_account_no,
					current_location		= v_patient_location,
					current_residency 		= sp_util.parse_string(v_patient_residence, '^', 1),
					current_ward 			= sp_util.parse_string(v_patient_residence, '^', 2),
					address					= v_address
			 WHERE	patient_key		= v_patient_key;

			UPDATE	patientcontact
			   SET	phone_no				= SUBSTR(v_phone_no, 1, 3) || '-' || SUBSTR(v_phone_no, 4, 3) || '-' || SUBSTR(v_phone_no, 6, 4),
					fax_no					= v_fax_no,
					address					= v_address,
					city					= v_city,
					state					= v_state,
					country					= v_country,
					zipcode					= v_zipcode
			 WHERE	patient_key		= v_patient_key
			   AND	contact_type	= 'H';

			IF v_visit_number <> 'C' THEN
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'VISIT', v_visit_number);
				sp_patient.set_profile_string(v_patient_key, 'HL7', 'ACCOUNT', v_account_no);
			END IF;

			/*auto update by st_patient_updated trigger (2009/02/12)
			UPDATE study
			SET	patient_name		= v_patient_name2,
				patient_birth_dttm	= sp_util.to_dttm(SUBSTR(v_patient_birth_dttm2, 1, 8))
			WHERE 	patient_id = v_patient_id
			AND   patient_id_issuer		= v_patient_id_issuer_code		-- changed 2009/02/10
			AND   validate_dttm is not NULL;							-- changed 2009/02/10

			UPDATE visit
			SET visit_no				= v_visit_number2,
				visit_stat			= v_visit_stat2,
			SET	patient_location		= v_patient_location2,
				refer_doctor_key		= sp_user.lookup_key(v_refer_doctor_id2)	--,
				consult_doctor_key		= sp_user.lookup_key(v_consult_doctor_id2)
			WHERE patient_key			= v_patient_key;

			-- put(addnew/modify) guarantor
				-- if not exist gtr

			v_patientgrt_key := sp_mapper.look_up_patient_gtr_key(v_patient_key);
		-- then addnew
			IF v_patientgrt_key IS NULL THEN
				v_patientgrt_key := sp_patient.addnew_guarantor(v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			ELSE
				sp_patient.modify_guarantor(v_patientgrt_key, v_patient_key, v_gtr_relation_code_key,
						v_guarantor_no,v_gtr_last_name, v_gtr_first_name, v_gtr_middle_name, v_gtr_prefix, v_gtr_suffix, v_guarantor_birth_dttm,
						v_guarantor_sex, v_guarantor_ssn, v_gtr_phone_no, v_gtr_fax_no, v_gtr_address,			-- guaranator
						v_gtr_city, v_gtr_state, v_gtr_zipcode, v_gtr_country, v_gtr_emp_name, v_gtr_emp_phone_no,
						v_gtr_emp_fax_no, v_gtr_emp_address, v_gtr_emp_city, v_gtr_emp_state, v_gtr_emp_zipcode,
						v_gtr_emp_country, v_gtr_emp_comments);
			END IF;*/

		END IF;

		RETURN v_patient_key;
	END;

-------------------------------------------------------------------------------------------------
-- additional procedure
-------------------------------------------------------------------------------------------------
	PROCEDURE remove_study
	(
		v_study_key				IN study.study_key%TYPE,
		v_remover_key			IN users.user_key%TYPE,
		v_force					IN BOOLEAN := FALSE
	)
	IS
		CURSOR cv_series IS
			SELECT series_key
			FROM series
			WHERE study_key = v_study_key;
		v_series_key			series.series_key%TYPE;
	BEGIN
		-- required condition to purge study
		-- 1. not ordered (order_key is NULL)

		-- check order status
		/*IF lookup_order_key(v_study_key) IS NOT NULL THEN
			RAISE_APPLICATION_ERROR(-20305, 'sp_study: remove failed: Study is a requested(scheduled) procedure');
		END IF;*/

		-- remove all series
		OPEN cv_series;
		LOOP
			FETCH cv_series INTO v_series_key;
			EXIT WHEN cv_series%NOTFOUND;
			sp_series.remove(v_series_key, v_remover_key, v_force);
		END LOOP;
		CLOSE cv_series;
		-- set remove mark on study itself
		sp_study.set_sts_stat(v_study_key, 'R');
		-- remove study itself
		IF v_force = TRUE THEN
			DELETE FROM study
			WHERE study_key = v_study_key;
		END IF;
	END;
	-------------------------------------------------------------------------------------------------
	PROCEDURE Study_modify
	(
		v_study_key				IN study.study_key%TYPE,
		v_procplan_key			IN study.procplan_key%TYPE,
		v_study_reason			IN study.study_reason%TYPE,
		v_study_comments		IN study.study_comments%TYPE,
		v_study_priority		IN study.study_priority%TYPE,
		v_patient_arrange		IN study.patient_arrange%TYPE,
		v_access_no				IN study.access_no%TYPE,
		v_other_patient_id		IN study.other_patient_id%TYPE,
		v_other_patient_name	IN study.other_patient_name%TYPE
	)
	IS
	BEGIN
		UPDATE study
		SET study_reason		= v_study_reason,
			study_comments		= v_study_comments,
			study_priority		= v_study_priority,
			patient_arrange		= v_patient_arrange,
			access_no			= v_access_no,
			other_patient_id	= v_other_patient_id,
			other_patient_name	= v_other_patient_name
		WHERE study_key = v_study_key;

		UPDATE study
		SET (study_desc, procplan_key, request_code, request_name) =
			(SELECT procplan_desc, procplan_key, code_value, procplan_desc FROM procplan WHERE procplan_key = v_procplan_key)
		WHERE study_key = v_study_key;
	END;
	-------------------------------------------------------------------------------------------------
	PROCEDURE Iorder_modify
	(
		v_order_key					IN iorder.order_key%TYPE,
		v_patient_key				IN iorder.patient_key%TYPE,
		v_visit_key					IN iorder.visit_key%TYPE,
		v_placer_order_id			IN iorder.placer_order_id%TYPE,
		v_order_reason				IN iorder.order_reason%TYPE,
		v_order_comments			IN iorder.order_comments%TYPE,
		v_order_doctor_key			IN iorder.order_doctor_key%TYPE,
		v_refer_doctor_key			IN iorder.refer_doctor_key%TYPE,
		v_order_department_code		IN iorder.order_department_code%TYPE,
		v_order_entry_user_key		IN iorder.order_entry_user_key%TYPE,
		v_order_entry_location		IN iorder.order_entry_location%TYPE,
		v_order_callback_phone_no	IN iorder.order_callback_phone_no%TYPE,
		v_patinsu1_key				IN iorder.patinsu1_key%TYPE := NULL,
		v_patinsu2_key				IN iorder.patinsu2_key%TYPE := NULL,
		v_order_dttm				IN iorder.order_dttm%TYPE
	)
	IS
	BEGIN
		UPDATE iorder
		SET patient_key				= v_patient_key,
			visit_key				= v_visit_key,
			placer_order_id			= v_placer_order_id,
			order_reason			= v_order_reason,
			order_comments			= v_order_comments,
			order_doctor_key		= v_order_doctor_key,
			refer_doctor_key		= v_refer_doctor_key,
			order_department_code	= v_order_department_code,
			order_entry_user_key	= v_order_entry_user_key,
			order_entry_location	= v_order_entry_location,
			order_callback_phone_no	= v_order_callback_phone_no,
			patinsu1_key			= v_patinsu1_key,
			patinsu2_key			= v_patinsu2_key,
			order_dttm				= v_order_dttm,
			order_stat				= NULL
		WHERE order_key = v_order_key;
	END;
	-------------------------------------------------------------------------------------------------
	PROCEDURE update_doctor
	(
		v_study_key					IN study.study_key%TYPE,
		v_refer_doctor_key			IN NUMBER := NULL,
		v_request_doctor_key		IN NUMBER := NULL,
		v_consult_doctor_key		IN NUMBER := NULL,
		v_attend_doctor_key			IN NUMBER := NULL,
		v_perform_doctor_key		IN NUMBER := NULL,
		v_study_reason				IN study.study_reason%TYPE := NULL
	)
	IS
		v_last_name					VARCHAR(64);
		v_first_name				VARCHAR(64);
		v_middle_name				VARCHAR(64);
		v_prefix					VARCHAR(64);
		v_suffix					VARCHAR(64);
		v_refer_doctor_name			VARCHAR(64);
		v_request_doctor_name		VARCHAR(64);
		v_consult_doctor_name		VARCHAR(64);
		v_attend_doctor_name		VARCHAR(64);
		v_perform_doctor_name		VARCHAR(64);
	BEGIN
		--SELECT UPPER(last_name) || ', ' || UPPER(first_name)
		SELECT sp_study.get_doctor_name(last_name,first_name,middle_name,prefix,suffix,user_name) INTO v_refer_doctor_name
		FROM SV_MASTER_USERS
		WHERE user_key = v_refer_doctor_key;

		--SELECT UPPER(last_name) || ', ' || UPPER(first_name)
		IF v_request_doctor_key IS NOT NULL THEN
			SELECT sp_study.get_doctor_name(last_name,first_name,middle_name,prefix,suffix,user_name) INTO v_request_doctor_name
			FROM SV_MASTER_USERS
			WHERE user_key = v_request_doctor_key;
		ELSE
			v_request_doctor_name := '';
		END IF;

		IF v_consult_doctor_key IS NOT NULL THEN
			SELECT sp_study.get_doctor_name(last_name,first_name,middle_name,prefix,suffix,user_name) INTO v_consult_doctor_name
			FROM SV_MASTER_USERS
			WHERE user_key = v_consult_doctor_key;
		ELSE
			v_consult_doctor_name := '';
		END IF;

		IF v_attend_doctor_key IS NOT NULL THEN
			SELECT sp_study.get_doctor_name(last_name,first_name,middle_name,prefix,suffix,user_name) INTO v_attend_doctor_name
			FROM SV_MASTER_USERS
			WHERE user_key = v_attend_doctor_key;
		ELSE
			v_attend_doctor_name := '';
		END IF;

		IF v_perform_doctor_key IS NOT NULL THEN
			SELECT sp_study.get_doctor_name(last_name,first_name,middle_name,prefix,suffix,user_name) INTO v_perform_doctor_name
			FROM SV_MASTER_USERS
			WHERE user_key = v_perform_doctor_key;
		ELSE
			v_perform_doctor_name := '';
		END IF;

		UPDATE study
		SET study_reason		= v_study_reason,
			refer_doctor		= v_refer_doctor_name,
			request_doctor		= v_request_doctor_name,
			consult_doctor		= v_consult_doctor_name,
			attend_doctor		= v_attend_doctor_name,
			perform_doctor		= v_perform_doctor_name
		WHERE study_key = v_study_key;
	END;
	-------------------------------------------------------------------------------------------------
	PROCEDURE user_modify
	(
		v_study_key						IN study.study_key%TYPE,
		v_refer_doctor_key				IN NUMBER := NULL,
		v_request_doctor_key			IN NUMBER := NULL,
		v_study_reason					IN study.study_reason%TYPE := NULL
	)
	IS
		v_refer_doctor_name				VARCHAR(64);
		v_request_doctor_name			VARCHAR(64);
	BEGIN
		SELECT user_name
		INTO v_refer_doctor_name
		FROM users
		WHERE user_key = v_refer_doctor_key;

		SELECT user_name
		INTO v_request_doctor_name
		FROM users
		WHERE user_key = v_request_doctor_key;

		UPDATE study
		SET study_reason		= v_study_reason,
			refer_doctor		= sp_util.upper(v_refer_doctor_name),
			request_doctor		= sp_util.upper(v_request_doctor_name)
		WHERE study_key = v_study_key;
	END;
	-------------------------------------------------------------------------------------------------
	PROCEDURE put_department_unmatched
	(
		v_department_code				IN VARCHAR2,
		v_department_name				IN VARCHAR2
	)
	IS
		v_return_department_code		department.department_code%TYPE;
	BEGIN
		v_return_department_code := sp_department.put(v_department_code, v_department_name);
	END;
-------------------------------------------------------------------------------------------------
-- additional function
-------------------------------------------------------------------------------------------------
	FUNCTION Study_addnew
	(
		v_order_key					IN study.order_key%TYPE,
		v_procplan_key				IN study.procplan_key%TYPE,
		v_study_reason				IN study.study_reason%TYPE,
		v_study_comments			IN study.study_comments%TYPE,
		v_study_priority			IN study.study_priority%TYPE,
		v_patient_arrange			IN study.patient_arrange%TYPE,
		v_patient_location			IN study.patient_location%TYPE := NULL,
		v_access_no					IN study.access_no%TYPE := NULL,
		v_study_instance_uid		IN study.study_instance_uid%TYPE := NULL,
		v_other_patient_name		IN study.other_patient_name%TYPE
	)
	RETURN study.study_key%TYPE
	IS
		v_study_key					study.study_key%TYPE;
		v_default_study_stat		study.study_stat%TYPE;
		v_new_access_no				study.access_no%TYPE := NULL;
		v_new_study_instance_uid	study.study_instance_uid%TYPE := NULL;
		v_accession_no_digit		NUMBER;
		v_accession_no_padding		VARCHAR2(32);
		v_accession_no_prefix		VARCHAR2(1024);
		v_exam_code					study.study_id%TYPE := '';
		v_is_accessno_number_type	NUMBER := 0;

	BEGIN
		SELECT sq_study.nextval INTO v_study_key FROM dual;

		v_new_access_no := v_access_no;

		IF (v_study_instance_uid IS NULL) THEN
			if v_access_no IS NULL THEN
				v_accession_no_digit := SP_PROFILE.get_number('ORDER', 'ACCESSION_NO_DIGIT', 6);
				v_accession_no_prefix := SP_PROFILE.get_string('ORDER', 'ACCESSION_NO', 'RAD.AN.');
				v_accession_no_padding := SP_UTIL.padding_data(v_study_key, v_accession_no_digit);
				v_new_access_no := v_accession_no_prefix || v_accession_no_padding;

				v_new_study_instance_uid := sp_uiddict.generate_uid || '.' || v_study_key;
			ELSE
				SELECT NVL2(TRIM(TRANSLATE(v_access_no,'1234567890.','           ')),0,1) INTO v_is_accessno_number_type FROM dual;

				IF v_is_accessno_number_type = 1 THEN
					v_new_study_instance_uid := sp_uiddict.generate_uid || '.' || v_study_key || '.' || v_access_no;
				ELSE
					v_new_study_instance_uid := sp_uiddict.generate_uid || '.' || v_study_key;
				END IF;
			END IF;
		ELSE
			v_new_study_instance_uid := v_study_instance_uid;
		END IF;

		IF UPPER(SP_PROFILE.get_string('STUDY', 'STUDY_ID', 'Default')) = 'DEFAULT' THEN
			v_exam_code := TO_CHAR(v_study_key);
		END IF;


		INSERT INTO study
		(
		-- patient
			patient_id,
			patient_id_issuer,
			other_patient_id,
			patient_name,
			patient_birth_dttm,
			patient_sex,
			patient_size,
			patient_weight,
			special_needs,
			patient_age,
			patient_age_in_days,
			patient_location,
			patient_account_no,
		-- order
			order_key,
			request_dttm,
			access_no,
			request_doctor,
			refer_doctor,
			request_department,
		-- reqproc
			study_key,
			study_stat,
			study_instance_uid,
			study_id,
			procplan_key,
			study_reason,
			study_comments,
			study_priority,
			patient_arrange,
			creation_dttm
		)
		SELECT
		-- patient
			pat.patient_id,
			pat.patient_id_issuer,
			pat.patient_ssn,
			pat.patient_name,
			pat.patient_birth_dttm,
			pat.patient_sex,
			pat.patient_size,
			pat.patient_weight,
			pat.special_needs,
			sp_util.compute_age(pat.patient_birth_dttm),
			ord.order_dttm - pat.patient_birth_dttm,
			v_patient_location,
			pat.account_no,
		-- order
			ord.order_key,
			ord.order_dttm,
			v_new_access_no,
			sp_util.encode_name(odr.last_name, odr.first_name, odr.middle_name, odr.prefix, odr.suffix),
			sp_util.encode_name(rdr.last_name, rdr.first_name, rdr.middle_name, rdr.prefix, rdr.suffix),
			ord.order_department_code,
		-- reqproc
			v_study_key,
			100,
			v_new_study_instance_uid,
			v_exam_code,
			v_procplan_key,
			v_study_reason,
			v_study_comments,
			v_study_priority,
			v_patient_arrange,
			SYSDATE
		FROM patient pat, iorder ord, users odr, users rdr
		WHERE pat.patient_key = ord.patient_key
		AND ord.order_key = v_order_key
		AND ord.order_doctor_key = odr.user_key(+)
		AND ord.refer_doctor_key = rdr.user_key(+);

		UPDATE study
		SET (study_desc, request_code, request_name) =
			(SELECT procplan_desc, code_value, procplan_desc FROM procplan WHERE procplan_key = v_procplan_key)
		WHERE study_key = v_study_key;

	--update patient's patient_location
		UPDATE	patient
		SET		current_location = v_patient_location
		WHERE	patient_key = (SELECT patient_key FROM iorder WHERE order_key = v_order_key);

		UPDATE study
		SET other_patient_name = v_other_patient_name
		WHERE study_key = v_study_key;

		RETURN v_study_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_procplan_unmatched
	(
		v_code_value					IN VARCHAR2,
		v_code_scheme					IN VARCHAR2,
		v_code_version					IN VARCHAR2,
		v_code_meaning					IN VARCHAR2
	)
	RETURN procplan.procplan_key%TYPE
	IS
		v_default_code_scheme			VARCHAR2(32) := 'CPT';
		v_default_code_version			VARCHAR2(32) := NULL;

		v_new_code_scheme				VARCHAR2(32);
		v_new_code_version				VARCHAR2(32);

		v_procplan_key					procplan.procplan_key%TYPE;

	BEGIN
		-- addnew for new procplan, protocol, procplanprotocol
		IF v_code_scheme IS NULL THEN
			v_new_code_scheme := v_default_code_scheme;
		ELSE
			v_new_code_scheme := v_code_scheme;
		END IF;

		IF v_code_version IS NULL THEN
			v_new_code_version := v_default_code_version;
		ELSE
			v_new_code_version := v_code_version;
		END IF;

		v_procplan_key := sp_procplan.addnew(v_code_meaning, NULL, v_code_value, v_new_code_scheme, v_new_code_version, v_code_meaning, NULL);

		RETURN v_procplan_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_procplan_unmatched
	(
		v_code_value					IN VARCHAR2,
		v_code_scheme					IN VARCHAR2,
		v_code_version					IN VARCHAR2,
		v_code_meaning	 				IN VARCHAR2,
		v_reqproc_desc	 				IN VARCHAR2
	)
	RETURN procplan.procplan_key%TYPE
	IS
		v_default_code_scheme			VARCHAR2(32);
		v_default_code_version			VARCHAR2(32) := NULL;

		v_new_code_scheme				VARCHAR2(32);
		v_new_code_version		 		VARCHAR2(32);

		v_procplan_key					procplan.procplan_key%TYPE;
	BEGIN
		v_default_code_scheme := get_institution_code;

		-- addnew for new procplan, protocol, procplanprotocol
		IF v_code_scheme IS NULL THEN
			v_new_code_scheme := v_default_code_scheme;
		ELSE
			v_new_code_scheme := v_code_scheme;
		END IF;

		IF v_code_version IS NULL THEN
			v_new_code_version := v_default_code_version;
		ELSE
			v_new_code_version := v_code_version;
		END IF;

		v_procplan_key := sp_procplan.addnew(v_reqproc_desc, NULL, v_code_value, v_new_code_scheme, v_new_code_version, v_code_meaning, NULL);

		RETURN v_procplan_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE
	IS
		v_user_key						users.user_key%TYPE;
		v_default_institution_code		VARCHAR2(8) := NULL;
	BEGIN
		v_user_key := sp_user.addnew(v_user_id, v_user_id, v_user_id, NULL, v_level_code);
		sp_user.set_lock(v_user_key);

		RETURN v_user_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE
	IS
		v_user_key						users.user_key%TYPE;
		v_default_institution_code		VARCHAR2(8) := NULL;
		v_patient_name					VARCHAR2(64);
	BEGIN

		v_patient_name := sp_util.encode_name(v_last_name, v_first_name, NULL,NULL, NULL);
		v_user_key := sp_user.addnew(v_user_id, v_user_id, v_patient_name, NULL, v_level_code);
		--sp_user.set_lock(v_user_key);

		RETURN v_user_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_user_unmatched
	(
		v_user_id						IN VARCHAR2,
		v_password						IN VARCHAR2,
		v_last_name						IN VARCHAR2,
		v_first_name					IN VARCHAR2,
		v_level_code					IN NUMBER
	)
	RETURN users.user_key%TYPE
	IS
		v_user_key						users.user_key%TYPE;
		v_default_institution_code		VARCHAR2(8) := NULL;
		v_user_name						VARCHAR2(70);
	BEGIN
		v_user_name := v_last_name || '^' || v_first_name;
		v_user_key := sp_user.addnew(v_user_id, v_password, v_user_name, NULL, v_level_code);
		--sp_user.set_lock(v_user_key);

		RETURN v_user_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION put_station_unmatched
	(
		v_modality_code					IN VARCHAR2,
		v_source_aetitle				IN VARCHAR2,
		v_institution_code				IN VARCHAR2 := NULL
	)
	RETURN station.station_key%TYPE
	IS
		v_station_key					station.station_key%TYPE;
		v_count							NUMBER;
		v_station_class_code_key		NUMBER := NULL;
	BEGIN                
 		v_station_class_code_key := sp_codedict.lookup_code_key('STATIONCLASS', 'MOD', 'INFINITT', NULL);

		dbms_output.put_line('1.v_source_aetitle:' || v_source_aetitle);		
		v_station_key := sp_station.put
		(
			v_source_aetitle, v_modality_code, 104, NULL, v_modality_code, 
			v_modality_code, v_modality_code, NULL, NULL, NULL, 
			v_station_class_code_key, NULL, NULL, NULL, v_institution_code
		);
        dbms_output.put_line('2.v_station_key:' || v_station_key);

		SELECT	COUNT(0) INTO v_count
		FROM	stationmod
		WHERE	station_key = v_station_key
		AND		modality_code = v_modality_code;
        dbms_output.put_line('3.v_station_key:' || v_station_key);

		IF v_count = 0 THEN
			sp_station.addnew_station_mod(v_station_key, v_modality_code);
		END IF;

		RETURN v_station_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_order_key
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.order_key%TYPE
	IS
		v_order_key						study.order_key%TYPE;
	BEGIN
		SELECT	order_key INTO v_order_key
		FROM	study
		WHERE	access_no = v_access_no
		AND		order_key IS NOT NULL;

		RETURN v_order_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	------------------------------------------------------------------------------------------------
	FUNCTION lookup_key_acn
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE
	IS
		v_study_key						study.study_key%TYPE;
	BEGIN
		SELECT	study_key INTO v_study_key
		FROM	study
		WHERE	access_no = v_access_no
		AND		validate_dttm IS NULL;

		RETURN v_study_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_protocol_key
	(
		v_reqproc_code_value			IN VARCHAR2,
		v_modality						IN VARCHAR2
	)
	RETURN protocol.protocol_key%TYPE
	IS
		v_protocol_key					protocol.protocol_key%TYPE;
	BEGIN
		SELECT	protocol_key INTO v_protocol_key
		FROM	protocol
		WHERE	protocol_desc = v_reqproc_code_value
		AND		modality_code = v_modality
		AND		rownum < 2;

		RETURN v_protocol_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_institution_code
	RETURN VARCHAR2
	IS
		v_institution_code				VARCHAR2(8);
	BEGIN
		SELECT	NVL(institution_code, 'MAIN')
		INTO	v_institution_code
		FROM	volume
		WHERE	volume_type='D'
		AND		rownum = 1;

		RETURN v_institution_code;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_institution_code
	(
		v_idissuer_code					IN VARCHAR2
	)
	RETURN VARCHAR2
	IS
		v_institution_code				VARCHAR2(32);
	BEGIN
		SELECT	institution_code INTO v_institution_code
		FROM	idissuer
		WHERE	issuer_code = v_idissuer_code
		AND		rownum = 1;

		RETURN v_institution_code;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_issuer_code
	(
		v_aetitle					IN station.aetitle%TYPE
	)
	RETURN idissuer.issuer_code%TYPE
	IS
		v_issuer_code				idissuer.issuer_code%TYPE;
		v_institution_code			station.institution_code%TYPE;
	BEGIN

		SELECT	institution_code INTO v_institution_code
		FROM	station
		WHERE	aetitle = v_aetitle;

		RETURN get_issuer_code(v_institution_code);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	------------------------------------------------------------------------------------------------
	FUNCTION get_issuer_code
	(
		v_institution_code				IN idissuer.institution_code%TYPE
	)
	RETURN idissuer.issuer_code%TYPE
	IS
		v_issuer_code					idissuer.issuer_code%TYPE;
	BEGIN
		SELECT	issuer_code INTO v_issuer_code
		FROM	idissuer
		WHERE	institution_code = v_institution_code
		AND		rownum = 1;

		RETURN v_issuer_code;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION get_sps_end_dttm
	(
		v_sps_start_dttm				IN msps.sps_start_dttm%TYPE,
		v_protocol_key					IN protocol.protocol_key%TYPE
	)
	RETURN msps.sps_end_dttm%TYPE
	IS
		v_duration						NUMBER := 15;
		v_sps_end_dttm					msps.sps_end_dttm%TYPE;
	BEGIN
		SELECT	NVL(duration, 15) INTO v_duration
		FROM	protocol
		WHERE	protocol_key = v_protocol_key;
		
		v_sps_end_dttm := v_sps_start_dttm + ((v_duration - 1) / (60 * 24));
		
		RETURN v_sps_end_dttm;
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_station_key_by_modality
	(
		v_modality						IN VARCHAR2
	)
	RETURN stationmod.station_key%TYPE
	IS
		v_station_key					stationmod.station_key%TYPE;
	BEGIN
		SELECT	station_key INTO v_station_key
		FROM	stationmod
		WHERE	modality_code = v_modality
		AND rownum < 2;

		RETURN v_station_key;
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;		
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_patientcontact_key
	(
		v_patient_key					IN patientcontact.patient_key%TYPE,
		v_contact_type					IN patientcontact.contact_type%TYPE
	)
	RETURN patientcontact.patientcontact_key%TYPE
	IS
		v_patientcontact_key			patientcontact.patientcontact_key%TYPE;
	BEGIN
		SELECT	patientcontact_key INTO v_patientcontact_key
		FROM	patientcontact
		WHERE	patient_key = v_patient_key
		AND		contact_type = v_contact_type;
		RETURN v_patientcontact_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION parse_count
	(
		v_string					IN VARCHAR2,
		v_separator					IN CHAR
	)
	RETURN NUMBER
	IS
		v_length					NUMBER;
		v_count						NUMBER;
	BEGIN
		v_count := 0;
		v_length := LENGTH(v_string);

		FOR i IN 1..v_length LOOP
			IF v_separator = SUBSTR(v_string,i,1) THEN
				v_count := v_count + 1;
			END IF;
		END LOOP;

		RETURN v_count;

	EXCEPTION
		WHEN OTHERS THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION insert_newline
	(
		v_text							IN VARCHAR2,
		v_seperator						IN VARCHAR2
	)
	RETURN VARCHAR2
	IS
		v_return						VARCHAR2(4000);
		v_count							NUMBER;
	BEGIN
		v_count := parse_count(v_text, '~');

		IF v_count > 0 THEN
			FOR i IN 1..v_count LOOP
				v_return := v_return || sp_util.parse_string(v_text, v_seperator, i) || chr(13) || chr(10);
			END LOOP;

		ELSE
			v_return := v_text;

		END IF;

		RETURN v_return;

	EXCEPTION
		WHEN OTHERS THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_study_key_for_report
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE
	IS
		v_study_key						study.study_key%TYPE;
	BEGIN
		SELECT	study_key INTO v_study_key
		FROM	study
		WHERE	access_no = v_access_no
		AND		merge_key IS NULL
		AND		order_key IS NOT NULL;
		RETURN v_study_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION lookup_study_key_for_report_2   -- for INA 
	(
		v_access_no						IN study.access_no%TYPE
	)
	RETURN study.study_key%TYPE
	IS
		v_study_key						study.study_key%TYPE;
	BEGIN
		SELECT	study_key INTO v_study_key
		FROM	study
		WHERE	access_no = v_access_no
		AND		merge_key IS NULL
		AND 	instance_count > 0 
		AND 	validate_dttm IS NOT NULL;
		RETURN v_study_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------
	FUNCTION lookup_usercontact_key
	(
		v_user_key						IN usercontact.user_key%TYPE,
		v_contact_type					IN usercontact.contact_type%TYPE
	)
	RETURN usercontact.usercontact_key%TYPE
	IS
		v_usercontact_key				usercontact.usercontact_key%TYPE;
	BEGIN
		SELECT	usercontact_key INTO v_usercontact_key
		FROM	usercontact
		WHERE	user_key = v_user_key
		AND		contact_type = v_contact_type;
		RETURN v_usercontact_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION xpatient_lookup_key
	(
		v_vendor						IN xpatient.vendor%TYPE,
		v_vendor_pat_id					IN xpatient.vendor_pat_id%TYPE
	)RETURN xpatient.xpatient_key%TYPE
	IS
		v_xpatient_key 			xpatient.xpatient_key%TYPE;
	BEGIN
		SELECT xpatient_key INTO v_xpatient_key
		FROM xpatient
		WHERE vendor = v_vendor and vendor_pat_id = v_vendor_pat_id;
		RETURN v_xpatient_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION xphysician_lookup_key
	(
		v_vendor						IN xphysician.vendor%TYPE,
		v_vendor_phy_id					IN xphysician.vendor_phy_id%TYPE
	)RETURN xphysician.xphysician_key%TYPE
	IS
		v_xphysician_key 			xphysician.xphysician_key%TYPE;
	BEGIN
		SELECT xphysician_key INTO v_xphysician_key
		FROM xphysician
		WHERE vendor = v_vendor and vendor_phy_id = v_vendor_phy_id;
		RETURN v_xphysician_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION xprocedure_lookup_key
	(
		v_vendor						IN xprocedure.vendor%TYPE,
		v_vendor_proc_code				IN xprocedure.vendor_proc_code%TYPE
	)RETURN xprocedure.xprocedure_key%TYPE
	IS
		v_xprocedure_key 			xprocedure.xprocedure_key%TYPE;
	BEGIN
		SELECT xprocedure_key INTO v_xprocedure_key
		FROM xprocedure
		WHERE vendor = v_vendor and vendor_proc_code = v_vendor_proc_code;
		RETURN v_xprocedure_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION xorm_lookup_key
	(
		v_vendor						IN xorm.vendor%TYPE,
		v_vendor_pat_id					IN xorm.vendor_pat_id%TYPE,
		v_vendor_phy_id					IN xorm.vendor_phy_id%TYPE,
		v_vendor_proc_code				IN xorm.vendor_proc_code%TYPE
	)RETURN xorm.xorm_key%TYPE
	IS
		v_xorm_key				xorm.xorm_key%TYPE;
	BEGIN
		SELECT xorm_key INTO v_xorm_key
		FROM xorm
		WHERE vendor = v_vendor and vendor_pat_id = v_vendor_pat_id and vendor_phy_id = v_vendor_phy_id and vendor_proc_code = v_vendor_proc_code;
		RETURN v_xorm_key;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_report_text
	(
		v_report_key					IN NUMBER
	)
	RETURN clob
	IS
		v_cnter							NUMBER;
		v_alink_key						NUMBER;
		v_study_key						NUMBER;
		v_report_text					clob;
		v_ret							clob;
	BEGIN
		SELECT alink_key, study_key, report_text_lob INTO v_alink_key, v_study_key, v_ret FROM report WHERE report_key = v_report_key;

		IF v_alink_key IS NOT NULL THEN
			v_ret := NULL;
			FOR VC2 IN (SELECT report_key, report_text_lob FROM report WHERE study_key = v_study_key ORDER BY report_key DESC)
			LOOP
				v_ret := v_ret || VC2.report_text_lob || CHR(13) || CHR(10);
			END LOOP;
		END IF; 

		RETURN v_ret;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_study_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2
	IS    
		v_return VARCHAR(64); 
	BEGIN                     
		select study_instance_uid into v_return
		from study
		where merge_key = v_study_key
		and source_aetitle <> 'BROKER';
		return v_return;               
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
	
	END;      
	-------------------------------------------------------------------------------------------------
	FUNCTION get_series_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2  
	IS   
       v_series_study_key NUMBER;
       v_series_uid NUMBER; 
       v_return VARCHAR(64); 
    BEGIN  
		select count(series_instance_uid) into v_series_uid
	    from series
	    where study_key = v_study_key and modality='SR' and series_instance_uid like '1.2.410.200010%' and series_no is null;
	   
	   If v_series_uid > 0 then
		   select max(series_instance_uid) into v_return 
		   from series
		   where study_key = v_study_key and modality='SR' and series_instance_uid like '1.2.410.200010%';                    
	   Else
			v_return :='1.2.410.200010.'||to_char(sysdate,'YYYYMMDDHH24MISS')||'.'||v_study_key;
	   End if;
						   
	   return v_return;              
           
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;	
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION get_sop_instance_uid
	(
		v_study_key		 IN NUMBER
	)
	RETURN VARCHAR2
	IS   
       v_sop_study_key NUMBER; 
       v_series_uid NUMBER;                      
       v_return VARCHAR2(64); 
    BEGIN  
        select count(series_instance_uid) into v_series_uid
        from series
        where study_key = v_study_key and modality='SR' and series_instance_uid like '1.2.410.200010%' and series_no is null;

        If v_series_uid >0 then                
		   select max(sop_instance_uid) into v_return 
		   from instance
		   where study_key = v_study_key and sop_class_key=68;
        Else
                v_return :='1.2.410.200010.'||to_char(sysdate,'YYYYMMDDHH24MISS')||'.'||v_study_key||'.'||to_char(sysdate,'HH24MISS');
        End if;
                               
        return v_return;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;	
	END;

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
		v_hl7message					IN hl7history.hl7message%TYPE,    	-- 10
		v_over4Kbyte					IN VARCHAR2,
		v_pre_history_key				IN hl7history.history_key%TYPE
	)
	RETURN hl7history.history_key%TYPE
	IS                                                                  
		v_history_key					NUMBER;     
		v_pre_hl7message				hl7history.hl7message%TYPE;    
		v_new_hl7message				hl7history.hl7message%TYPE;
		v_final_hl7message				hl7history.hl7message%TYPE;		

	BEGIN        
	
		IF v_over4Kbyte = '0' THEN		
			INSERT INTO hl7history 
			       (history_key, creation_dttm, interface_type, message_type, event_type, 
			        status, patient_id, patient_name, access_no, processing_id, reason_of_fail, hl7message)
		    VALUES (sq_hl7history.nextval, SYSDATE, v_interface_type, v_message_type, v_event_type, 
			        v_status, NVL(v_patient_id, 'Null'), NVL(v_patient_name, 'Null'), NVL(v_access_no, 'Null'), NVL(v_processing_id, 'Null'), v_reason_of_fail, v_hl7message);
			
	  	ELSE 		
	  		SELECT hl7message INTO v_pre_hl7message	  		
	  		FROM hl7history WHERE history_key = v_pre_history_key; 
	  		v_new_hl7message := v_pre_hl7message || v_hl7message; 	  	
	  		
	  		UPDATE hl7history SET hl7message = EMPTY_CLOB() 
	  		WHERE history_key = v_pre_history_key
	  		RETURNING hl7message INTO v_final_hl7message;           
	
	  		--dbms_output.put_line('v_new_hl7message=' || v_new_hl7message);
	  		DBMS_LOB.WRITE(v_final_hl7message, length(v_new_hl7message), 1, v_new_hl7message);
	  		
	    END IF;

    	SELECT sq_hl7history.currval INTO v_history_key FROM dual;	    
    	
		RETURN v_history_key;

	EXCEPTION
		WHEN OTHERS THEN
			RETURN 0;
	END;	
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
	RETURN NUMBER
	IS   
		v_report_key					report.report_key%TYPE;

	BEGIN   
		
		RETURN v_report_key;

	END;   
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
	RETURN NUMBER
	IS   
		v_report_key					report.report_key%TYPE;

	BEGIN   
		
		RETURN 1;

	END;
	-------------------------------------------------------------------------------------------------
	/*function encrypt_url(p_in_val IN VARCHAR2)
	RETURN VARCHAR2
	IS
		v_rCasted	RAW(1024);
		v_rKey		RAW(1024);
		v_rReturn	RAW(2048);   
		v_ProfileValue profile.value%TYPE;
	BEGIN 
		           
		IF  sp_profile.get_string('SECURITY', 'EXTERNAL_INTERFACE_AES') IS NULL THEN  
			v_ProfileValue := '128_OLD';  
		ELSE
			v_ProfileValue := sp_profile.get_string('SECURITY', 'EXTERNAL_INTERFACE_AES');
		END IF;

		IF v_ProfileValue = '128_OLD' THEN
			--AES128_old      
			dbms_output.put_line('v_ProfileValue' || ' - ' || v_ProfileValue);
			v_rCasted := utl_raw.cast_to_raw(p_in_val);
			v_rKey := utl_raw.cast_to_raw(sp_profile.get_string('SECURITY', 'EXTERNAL_INTERFACE_KEY', '0123SmartPacs456'));	   
			v_rReturn := dbms_crypto.encrypt(v_rCasted, dbms_crypto.ENCRYPT_AES128 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5, v_rKey, v_rKey);
		ELSIF v_ProfileValue = '128' THEN   
			--AES128                 
			dbms_output.put_line('v_ProfileValue' || ' - ' || v_ProfileValue);
			v_rCasted := utl_raw.cast_to_raw(p_in_val);
			v_rKey :=utl_raw.cast_to_raw(sp_profile.get_string('SECURITY', 'EXTERNAL_INTERFACE_KEY', '0000000000000000'));
			v_rReturn := dbms_crypto.encrypt(v_rCasted, dbms_crypto.ENCRYPT_AES128 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5, v_rKey);
		ELSIF v_ProfileValue = '256' THEN     
			--AES256 
			dbms_output.put_line('v_ProfileValue' || ' - ' || v_ProfileValue);
		 	v_rCasted := utl_raw.cast_to_raw(p_in_val);
			v_rKey := utl_raw.cast_to_raw(sp_profile.get_string('SECURITY', 'EXTERNAL_INTERFACE_KEY2', '00000000000000000000000000000000'));
			v_rReturn := dbms_crypto.encrypt(v_rCasted, dbms_crypto.ENCRYPT_AES256 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5, v_rKey);
		ELSE
			raise_application_error (-20001, 'not found profile value');
		END IF;

		return replace(utl_raw.cast_to_varchar2(utl_encode.base64_encode(v_rReturn)), chr(13) || chr(10), '');    		
	END;    */                               
	------------------------------------------------------------------------------------------------- 
	FUNCTION get_report_html
	(
		v_access_no				IN study.access_no%TYPE
	)
	RETURN clob
	IS       
		CURSOR cv_report IS
			SELECT r.report_key, r.study_key, r.report_text_lob, r.approver_key, r.approval_dttm
			FROM report r, study s
			WHERE s.access_no = v_access_no and s.study_key = r.study_key ORDER BY report_key ASC; 

		v_study_key						study.study_key%TYPE;
		v_report_key					report.report_key%TYPE;
		v_approver_key					report.approver_key%TYPE;
		v_approval_dttm					report.approval_dttm%TYPE;   
		v_approver_name					users.user_name%TYPE;
		v_report_text					clob;
		v_ret							clob;
	BEGIN  
		OPEN cv_report;
		LOOP
			FETCH cv_report INTO v_report_key, v_study_key, v_report_text, v_approver_key, v_approval_dttm;
			EXIT WHEN cv_report%NOTFOUND;   
			IF v_approver_key IS NOT NULL THEN
			 SELECT user_name INTO v_approver_name FROM users WHERE user_key= v_approver_key;     
			END IF;
			v_ret := v_report_text ||'[report by '||v_approver_name||' at report '||TO_CHAR(v_approval_dttm,'YYYYMMDDHH24MISS')||']'||'~'||v_ret ; 
		END LOOP;
		CLOSE cv_report;   

		RETURN v_ret;
	END;           
	-------------------------------------------------------------------------------------------------
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
	RETURN NUMBER
	IS
		v_PatientLocation_key	NUMBER;
		v_PatientResidency_key 	NUMBER;	
		v_Department_key		NUMBER;  
		 
		v_AttendDoctor_key		NUMBER;        
		v_ReferDoctor_key   	NUMBER;
		v_ConsultDoctor_key 	NUMBER;

		v_encounter_key			NUMBER;      
		v_count   				NUMBER;
				
	BEGIN    
	
		IF v_PriorPatientId IS NULL THEN
			v_PatientLocation_key  := get_ebiwcodedict('PATIENTLOCATION', v_PatientLocation);

			v_PatientResidency_key := get_ebiwcodedict('PATIENTRESIDENCY', v_PatientResidency);
			IF v_PatientResidency_key IS NOT NULL THEN
				SELECT count(0) INTO v_count FROM ebiwcodefacility WHERE ebiwcode_key = v_PatientResidency_key AND ebiwfacility_code = 'I';
				IF v_count = 0 THEN
					sp_ebiw.link_ebiwcodedict_facility(v_PatientResidency_key, 'I');
				END IF;
			END IF;
			
			v_Department_key := get_ebiwcodedict('DEPARTMENT', v_Department);
			IF v_Department_key IS NOT NULL THEN
				SELECT count(0) INTO v_count FROM ebiwcodefacility WHERE ebiwcode_key = v_Department_key AND ebiwfacility_code = 'I';
				IF v_count = 0 THEN
					sp_ebiw.link_ebiwcodedict_facility(v_Department_key, 'I');
				END IF;
            END IF;
            
			dbms_output.put_line('key='||v_PatientLocation_key||','||v_PatientResidency_key||','||v_Department_key);
	
			v_AttendDoctor_key := sp_user.lookup_key(v_AttendDoctorId);
			IF v_AttendDoctor_key IS NULL THEN
				v_AttendDoctor_key := put_user_unmatched(v_AttendDoctorId, 40);
			END IF;
	
			v_ReferDoctor_key := sp_user.lookup_key(v_ReferDoctorId);
			IF v_ReferDoctor_key IS NULL THEN
				v_ReferDoctor_key := put_user_unmatched(v_ReferDoctorId, 20);
			END IF;
			
			v_ConsultDoctor_key := sp_user.lookup_key(v_ConsultDoctorId);
			IF v_ConsultDoctor_key IS NULL THEN
				v_ConsultDoctor_key := put_user_unmatched(v_ConsultDoctorId, 40);
			END IF;
			--dbms_output.put_line('user='||v_AttendDoctor_key||','||v_ReferDoctor_key||','||v_ConsultDoctor_key);
	
			SELECT count(0)
			INTO   v_count
	        FROM   encounter
	        WHERE  patient_id = v_PatientId
	        AND    patient_id_issuer = v_PatientIdIssuer
	        AND    department = v_Department_key;
	        dbms_output.put_line('encounter='||v_PatientId||','||v_PatientIdIssuer||','||v_Department_key);
	        
	        IF v_count = 0 THEN		
				SELECT 	SQ_ENCOUNTER.NEXTVAL
				INTO	v_encounter_key
				FROM	dual;
						
				INSERT INTO ENCOUNTER 
				  ( ENCOUNTER_KEY, EVENT_TYPE, PATIENT_ID, PATIENT_ID_ISSUER, PATIENT_NAME
				  , OTHER_PATIENT_ID, OTHER_PATIENT_NAME, PATIENT_BIRTH_DTTM, PATIENT_SEX, PATIENT_LOCATION
				  , PATIENT_RESIDENCY, DEPARTMENT, ATTENDING_DOCTOR, REFERRING_DOCTOR, CONSULTING_DOCTOR
				  , VISIT_NUMBER, ADMIT_DTTM, DISCHARGE_DTTM, ENCOUNTER_TYPE, LAST_UPDATE_DTTM 
				  )
				VALUES
				  ( v_encounter_key, v_EventType, v_PatientId, v_PatientIdIssuer, v_PatientName, v_OtherPatientId
				  , v_OtherPatientName, TO_DATE(v_PatientBirthDttm,'yyyymmddhh24miss'), v_PatientSex, v_PatientLocation_key
				  , v_PatientResidency_key, v_Department_key, v_AttendDoctor_key , v_ReferDoctor_key, v_ConsultDoctor_key
				  , v_VisitNumber, TO_DATE(v_AdmitDttm,'yyyymmddhh24miss'), TO_DATE(v_DischargeDttm,'yyyymmddhh24miss'), 'Y', sysdate
				  );
		     ELSE    
	     		SELECT encounter_key
				INTO   v_encounter_key
		        FROM   encounter
		        WHERE  patient_id = v_PatientId
		        AND    patient_id_issuer = v_PatientIdIssuer
		        AND    department = v_Department_key;
		        
		     	UPDATE ENCOUNTER
		     	SET EVENT_TYPE = v_EventType,
		     		PATIENT_NAME = v_PatientName, 
		     		OTHER_PATIENT_ID = v_OtherPatientId, 
		     		OTHER_PATIENT_NAME = v_OtherPatientName,
				    PATIENT_BIRTH_DTTM = TO_DATE(v_PatientBirthDttm,'yyyymmddhh24miss'), 
				    PATIENT_SEX = v_PatientSex, 
				    PATIENT_LOCATION = v_PatientLocation_key, 
				    PATIENT_RESIDENCY = v_PatientResidency_key, 
				    DEPARTMENT = v_Department_key, 
				    ATTENDING_DOCTOR =  v_AttendDoctor_key, 
				    REFERRING_DOCTOR = v_ReferDoctor_key, 
				    CONSULTING_DOCTOR = v_ConsultDoctor_key , 
				    VISIT_NUMBER = v_VisitNumber,
				    ADMIT_DTTM = TO_DATE(v_AdmitDttm,'yyyymmddhh24miss'), 
				    DISCHARGE_DTTM = TO_DATE(v_DischargeDttm,'yyyymmddhh24miss'), 
				    LAST_UPDATE_DTTM = sysdate
				 WHERE encounter_key = v_encounter_key; 
		     END IF;
	    ELSE
	    	DELETE encounter 
	    	WHERE patient_id = v_PriorPatientId
	    	AND   patient_id_issuer = v_PatientIdIssuer;
	    END IF;
	     
		RETURN v_encounter_key;
	END;                                                                                               
	-------------------------------------------------------------------------------------------------	
	FUNCTION get_ebiwcodedict
	(
		v_ebiwsection_code 				IN VARCHAR2, 
		v_ebiwcode_value 				IN VARCHAR2		
	)                         
 	RETURN NUMBER
	IS       
		v_ebiwcode_key					NUMBER;
		v_ebiwcode_value_final		    VARCHAR2(8);
	BEGIN	              
		IF v_ebiwcode_value IS NOT NULL THEN       		
			v_ebiwcode_key := lookup_ebiwcodedict(v_ebiwsection_code, v_ebiwcode_value);
		                                     
		 	IF v_ebiwcode_key IS NULL THEN
				SELECT SQ_EBIWCODEDICT.NEXTVAL
				INTO   v_ebiwcode_key
			 	FROM   dual;		 
				
				INSERT INTO EBIWCODEDICT (EBIWCODE_KEY, EBIWSECTION_CODE, EBIWCODE_VALUE, EBIWCODE_MEANING, EBIWCODE_STAT)
		       VALUES (v_ebiwcode_key, v_ebiwsection_code, v_ebiwcode_value, v_ebiwcode_value, NULL);	     
		  	END IF;
	  	END IF;
	  	
		RETURN v_ebiwcode_key;				                                                                                                     
	END;		                                                                                          
	-------------------------------------------------------------------------------------------------	
	FUNCTION lookup_ebiwcodedict
	(
		v_ebiwsection_code 				IN VARCHAR2, 
		v_ebiwcode_value 				IN VARCHAR2		
	)                         
 	RETURN NUMBER
	IS     
		v_ebiwcode_key					NUMBER; 		
	BEGIN	
		SELECT ebiwcode_key
		INTO   v_ebiwcode_key
		FROM   ebiwcodedict
		WHERE  ebiwsection_code = v_ebiwsection_code
		AND	   ebiwcode_value = v_ebiwcode_value;  
		   	 
		RETURN v_ebiwcode_key;	 
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;								                                                                                                     
	END;			
  -------------------------------------------------------------------------------------------------       	
	PROCEDURE del_encounter
	IS
	BEGIN
		IF sp_profile.get_number('EBIW', 'AUTO_DELETE_DAYS_BY_ADMITDATE', 0) > 0 THEN
			DELETE encounter WHERE admit_dttm < sysdate - sp_profile.get_number('EBIW', 'AUTO_DELETE_DAYS_BY_ADMITDATE', 0);
		END IF;
			
		IF sp_profile.get_number('EBIW', 'AUTO_DELETE_DAYS_BY_DISCHARGEDATE', 0) > 0 THEN
			DELETE encounter WHERE discharge_dttm < sysdate - sp_profile.get_number('EBIW', 'AUTO_DELETE_DAYS_BY_DISCHARGEDATE', 0);
		END IF;
	END;		
  ------------------------------------------------------------------------------------------------- 	
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
		v_emergency						IN VARCHAR2,	--10
		v_special_doctor				IN VARCHAR2
	)
	RETURN NUMBER
	IS
		v_insurancefee_key				insurancefee.insurance_key%TYPE;	
	BEGIN
	
		SELECT sq_insurancefee.NEXTVAL
		INTO   v_insurancefee_key
	 	FROM   dual;		 
		
		INSERT INTO INSURANCEFEE 
		(
			INSURANCE_KEY, 
			STUDY_INSTANCE_UID, 
			PATIENT_ID, 
			PATIENT_BIRTH_DTTM, 
			REQUEST_DTTM, 
			REQUEST_CODE, 
			REQUEST_NAME, 
			ACCESSION_NO, 
			INSURANCE_CODE, 
			MODALITY, 
			EMERGENCY, 
			SPECIAL_DOCTOR
		)
       VALUES 
       (
			v_insurancefee_key,
			v_study_instance_uid,
			v_patient_id,
			v_patient_birth_dttm,
			v_request_dttm,
			v_request_code,
			v_request_name,
			v_accession_no,
			v_insurance_code,
			v_modality,
			v_emergency,
			v_special_doctor
	   );	  
		RETURN v_insurancefee_key;
	END;
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
	RETURN NUMBER
	IS
		v_mdm_key					NUMBER;
	BEGIN
		--mdm process--
		---------------
		RETURN 1;
	END;
  
	------------------------------------------------------------------------------------------------- 	     
	
	FUNCTION version
	RETURN VARCHAR2
	IS
		v_workfile					VARCHAR2(64);
		v_revision					VARCHAR2(64);
		v_date						VARCHAR2(64);
	BEGIN
		v_workfile := LTRIM(RTRIM(TRANSLATE('$Workfile: PbdScript-SAMPLE.sql $', '$', ' ')));
		v_revision := LTRIM(RTRIM(TRANSLATE('$Revision: 4 $', '$', ' ')));
		v_date := LTRIM(RTRIM(TRANSLATE('$Date: 2011-05-27 $', '$', ' ')));
		RETURN v_workfile || ', ' || v_revision || ', ' || v_date;
	END;
	
	-------------------------------------------------------------------------------------------------
	
	FUNCTION get_AllReports
	(
		p_report_key			 	IN report.report_key%TYPE,
		p_remove_header_yn	IN NUMBER  := 0
	)
	RETURN CLOB
	IS                                                                  
        
		v_report_text_lob		report.report_text_lob%TYPE;
		v_Cnt	NUMBER;  
		v_idx	NUMBER;

	BEGIN
	       
			v_Cnt := 0;
			
			
			FOR q IN (SELECT r.report_text_lob, r.report_buffer_lob, s.study_stat, r.report_type
								FROM study s, (select study_key from report where report_key = p_report_key) s2, report r
								WHERE s.study_key = s2.study_key
									AND s.study_key = r.study_key
								order by r.report_key asc
					)
			LOOP  
			
				v_Cnt :=  v_Cnt + 1;        
				
				IF q.study_stat = 230 THEN --Transcribed

					IF v_Cnt > 1 THEN
						v_report_text_lob := v_report_text_lob || '~~[Addendum Report]~~' || q.report_buffer_lob || ' ';	
					ELSE
						v_report_text_lob := v_report_text_lob || q.report_buffer_lob;
					END IF; 

				ELSIF q.study_stat > 230 THEN

					IF v_Cnt > 1 THEN
						v_report_text_lob := v_report_text_lob || '~~[Addendum Report]~~' || q.report_text_lob || ' ';	
					ELSE
						v_report_text_lob := v_report_text_lob || q.report_text_lob;
					END IF;

				END IF;
				
				IF q.report_type = 'application/msword' AND p_remove_header_yn = 1 THEN
				
					SELECT 	INSTR(v_report_text_lob, 'FINAL REPORT', -1)
					INTO		v_idx
					FROM		DUAL;
					
					v_report_text_lob := SUBSTR(v_report_text_lob , v_idx);
					
					SELECT REPLACE(v_report_text_lob, '----------------- ADDENDUM - FINAL ----------------', '~~[Addendum Report]~~')
					INTO v_report_text_lob
					FROM DUAL;
				
				END IF;				

			END LOOP;
           
			RETURN v_report_text_lob; 			

	END;
	
	-------------------------------------------------------------------------------------------------
	FUNCTION create_pdf_convert_queue
	(
		p_pressrouteitem_key			 	IN pressrouteitem.pressrouteitem_key%TYPE
	)
	RETURN NUMBER
	IS
		v_pdf_queue_key		NUMBER;
		v_study_key			pressrouteitem.study_key%TYPE;
		v_bvalue			pressrouteitem.bvalue_lob%TYPE;
		v_mime_type			pdfconverterqueue.mime_type%TYPE;
	BEGIN
		
	 -- hl7routeitem table search
		select pdf_queue_key into v_pdf_queue_key 
		from hl7routeitem 
		where object_key = p_pressrouteitem_key;
		
		-- pressrouteitem_key�� pressrouteitem ���̺� ��ȸ �� study_key, bvalue_lob ����
		select bvalue_lob, study_key, object_mime into v_bvalue, v_study_key, v_mime_type  
		from pressrouteitem
		where pressrouteitem_key = p_pressrouteitem_key;
		
		if v_pdf_queue_key IS NULL THEN
		-- SP_PDFCONVERTER.put_pdfconverter_queue(study_key, bvalue_lob,...) ȣ���Ͽ� pdf convert que ���� �� PDF_QUEUE_KEY�� ���� ����
		-- hl7routeitem table update : [update hl7routeitem set PDF_QUEUE_KEY = PDF_QUEUE_KEY where object_key = pressrouteitem_key]
			sp_pdfconverter.request(v_study_key, v_bvalue, v_mime_type, v_pdf_queue_key);
			UPDATE hl7routeitem 
			SET
				pdf_queue_key = v_pdf_queue_key
			WHERE object_key = p_pressrouteitem_key;
		END IF; 
					
		RETURN v_pdf_queue_key;
	END;
	-------------------------------------------------------------------------------------------------
	FUNCTION ReturnPath 
	( 
		v_return_type			IN VARCHAR2,
		v_study_key				IN NUMBER
	)
	RETURN VARCHAR2
	IS   
		v_pdfPath				VARCHAR2(186);  
		v_thumbPath				VARCHAR2(186); 
		v_returnPath			VARCHAR2(186);
        v_approve_dttm			DATE;
        v_reporthistory_key		NUMBER;
        v_patient_id            VARCHAR2(10);   
        v_pdfExist				NUMBER;
        v_thumbExist			NUMBER;
	BEGIN
	   	--v_return_type :PS (source pdf file) PD: (destination pdf file)  X: xml file path 
	   	--v_return_type :JS (source jpeg thumb file) JD: (destination jpeg thumb  file)  
	   	/*select COUNT(1) into v_pdfExist from optrptsys.REPORTPDFPATHINFO where study_key = v_study_key;	
	   	if v_pdfExist > 0 then
	   		select pdfpath into v_pdfPath
			from optrptsys.REPORTPDFPATHINFO
			where study_key = v_study_key;  
		
		
			 select COUNT(1) into v_thumbExist from optrptsys.REPORTPDFTHUMBPATHINFO where study_key = v_study_key;	
			 if v_thumbExist > 0 then
				select pdfthumbpath into v_thumbPath
					from optrptsys.REPORTPDFTHUMBPATHINFO
					where study_key = v_study_key;
			end if;
			
	    	select APPROVAL_DTTM, REPORTHISTORY_KEY, PATIENT_ID into v_approve_dttm, v_reporthistory_key, v_patient_id 
			from study std, report rpt, optrptsys.REPORTPDFPATHINFO opt
			where std.study_key = v_study_key and std.study_key = rpt.study_key and opt.study_key = std.study_key; 
		   
		
			IF v_return_type = 'PS'  THEN
				v_returnPath := replace(replace(v_pdfPath, 'http://TachikawaVM/ReportPDF/', 'C:\grx\REPORTDATA\'), '/', '\');
			ELSIF v_return_type = 'PD'  THEN 
			  v_returnPath := '\\G32008R2MR_TEST\Image01\CITA\DATA\' || to_char(v_approve_dttm, 'YYYYMMDDHH24MISS') || '_' ||LPAD(v_reporthistory_key, 10, '0') || '_' || LPAD(v_patient_id, 10, '0') || '_0001.pdf';
			ELSIF v_return_type = 'JS'  THEN                                                                                    
				v_returnPath := replace(replace(v_thumbPath, 'http://TachikawaVM/ReportPDF/', 'C:\grx\REPORTDATA\'), '/', '\'); 
			ELSIF v_return_type = 'JD'  THEN 
			  v_returnPath := '\\G32008R2MR_TEST\Image01\CITA\DATA\' || to_char(v_approve_dttm, 'YYYYMMDDHH24MISS') || '_' ||LPAD(v_reporthistory_key, 10, '0') || '_' || LPAD(v_patient_id, 10, '0') || '_0001.jpeg';
			ELSE			
				v_returnPath := '\\G32008R2MR_TEST\Image01\CITA\DATA\' || to_char(v_approve_dttm, 'YYYYMMDDHH24MISS') || '_' ||LPAD(v_reporthistory_key, 10, '0') || '_' || LPAD(v_patient_id, 10, '0') || '.xml';
			END IF;  
		end if;*/
		RETURN v_returnPath;
	END; 
	-------------------------------------------------------------------------------------------------
END;
/
SHOW ERRORS