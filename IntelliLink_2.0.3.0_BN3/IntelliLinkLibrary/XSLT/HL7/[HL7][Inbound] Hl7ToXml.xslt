<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cs="urn:xslt-helpers">
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" omit-xml-declaration="no"/>

  <!-- ================================================================================== -->
  <!-- VARIABLE                                                                           -->
  <!-- ================================================================================== -->
  <!-- HL7 Keyword Replacer -->
  <xsl:variable name="REPETITION">
    <xsl:value-of select="'\R\'"/>
  </xsl:variable>
  <xsl:variable name="FIELD">
    <xsl:value-of select="'\F\'"/>
  </xsl:variable>
  <xsl:variable name="COMPONENT">
    <xsl:value-of select="'\S\'"/>
  </xsl:variable>
  <xsl:variable name="SUBCOMPONENT">
    <xsl:value-of select="'\T\'"/>
  </xsl:variable>

  <!-- ================================================================================== -->
  <!-- ROOT               																                                -->
  <!-- ================================================================================== -->
  <xsl:template match="text()"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:element name ="ROOT">
      <xsl:choose>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'ADT'">
          <xsl:call-template name="ADT"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'MFN'">
          <xsl:call-template name="MFN"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'ORM' or //MSH/MSH.9/MSH.9.1 = 'OMG' or //MSH/MSH.9/MSH.9.1 = 'OMI'">
          <xsl:call-template name="ORM"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'ORU'">
          <xsl:call-template name="ORU"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'QRY'">
          <xsl:call-template name="QRY"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'SIU'">
          <xsl:call-template name="SIU"/>
        </xsl:when>
        <xsl:when test="//MSH/MSH.9/MSH.9.1 = 'MDM'">
          <xsl:call-template name="MDM"/>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - ADT      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ADT">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="MRG"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - MFN      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MFN">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="MFI"/>
    <xsl:call-template name="MFE"/>
    <xsl:call-template name="STF"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - ORM      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORM">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="GT1"/>
    <xsl:call-template name="AL1"/>
    <xsl:call-template name="ORC"/>
    <xsl:call-template name="NTE"/>
    <xsl:call-template name="DG1"/>
    <xsl:call-template name="OBR"/>
    <xsl:element name="MSPS">
      <xsl:value-of select="cs:GetOneLineValue($MSPS, $REPETITION, $FIELD)"/>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - ORU      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORU">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="ORC"/>
    <xsl:call-template name="OBR"/>
    <xsl:call-template name="OBX"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - QRY      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="QRY">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="QRD"/>
    <xsl:call-template name="QRF"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - SIU      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="SIU">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="SCH"/>
    <xsl:call-template name="AIP"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - MDM      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MDM">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="TXA"/>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- SEGMENT - MSH : Message Header											                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MSH">
    <xsl:element name="MSH">
      <!-- MSH.3 - Sending Application -->
      <xsl:element name="SENDING_APPLICATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MSH/MSH.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MSH.4 - Sending Facility -->
      <xsl:element name="SENDING_FACILITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MSH/MSH.4"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MSH.5 - Receiving Application -->
      <xsl:element name="RECEIVING_APPLICATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MSH/MSH.5"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MSH.6 - Receiving Facility -->
      <xsl:element name="RECEIVING_FACILITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MSH/MSH.6"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MSH.9 - Message Type -->
      <xsl:element name="MESSAGE_TYPE">
        <xsl:value-of select="//MSH/MSH.9/MSH.9.1"/>^<xsl:value-of select="//MSH/MSH.9/MSH.9.2"/>
      </xsl:element>
      <!-- MSH.9.1 - Message Code -->
      <xsl:element name="MESSAGE_CODE">
        <xsl:value-of select="//MSH/MSH.9/MSH.9.1"/>
      </xsl:element>
      <!-- MSH.9.2 - Trigger Event -->
      <xsl:element name="TRIGGER_EVENT">
        <xsl:value-of select="//MSH/MSH.9/MSH.9.2"/>
      </xsl:element>
      <!-- MSH.10 - Message Control ID -->
      <xsl:element name="MESSAGE_CONTROL_ID">
        <xsl:value-of select="//MSH/MSH.10"/>
      </xsl:element>
      <!-- MSH.11 - Processing ID -->
      <xsl:element name="PROCESSING_ID">
        <xsl:value-of select="//MSH/MSH.11"/>
      </xsl:element>
      <!-- MSH.12 - Version ID -->
      <xsl:element name="VERSION_ID">
        <xsl:value-of select="//MSH/MSH.12"/>
      </xsl:element>
      <!-- MSH.13 - Sequence Number -->
      <xsl:element name="SEQUENCE_NUMBER">
        <xsl:value-of select="//MSH/MSH.13"/>
      </xsl:element>
      <!-- MSH.14 - Continuation Pointer -->
      <xsl:element name="CONTINUATION_POINTER">
        <xsl:value-of select="//MSH/MSH.14"/>
      </xsl:element>
      <!-- MSH.15 - Accept Acknowledgment Type -->
      <xsl:element name="ACCEPT_ACKNOWLEDGMENT_TYPE">
        <xsl:value-of select="//MSH/MSH.15"/>
      </xsl:element>
      <!-- MSH.16 - Application Acknowledgment Type -->
      <xsl:element name="APPLICATION_ACKNOWLEDGMENT_TYPE">
        <xsl:value-of select="//MSH/MSH.16"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - PID : Patient Identification							                                -->
  <!-- ================================================================================== -->
  <xsl:template name="PID">
    <xsl:element name="PID">
      <!-- PID.3 - Patient Identifier List -->
      <xsl:element name="PATIENT_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.3"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="ID_ISSUER_CODE">
        <xsl:choose>
          <xsl:when test="string-length(//PID/PID.3/PID.3.4) > 0">
            <xsl:value-of select="//PID/PID.3/PID.3.4"/>
          </xsl:when>
          <xsl:otherwise>JGH</xsl:otherwise>
        </xsl:choose>        
      </xsl:element>
      <!-- PID.4 - Alternate Patient ID -->
      <xsl:element name="GLOBAL_PATIENT_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.4"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.5 - Patient Name -->
      <xsl:element name="FULL_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.5"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="FAMILY_NAME">
        <xsl:value-of select="//PID/PID.5/PID.5.1"/>
      </xsl:element>
      <xsl:element name="GIVEN_NAME">
        <xsl:value-of select="//PID/PID.5/PID.5.2"/>
      </xsl:element>
      <xsl:element name="MIDDLE_NAME">
        <xsl:value-of select="//PID/PID.5/PID.5.3"/>
      </xsl:element>
      <xsl:element name="SUFFIX">
        <xsl:value-of select="//PID/PID.5/PID.5.4"/>
      </xsl:element>
      <xsl:element name="PREFIX">
        <xsl:value-of select="//PID/PID.5/PID.5.5"/>
      </xsl:element>
      <!-- PID.7 - Date/Time of Birth -->
      <xsl:element name="DATE_OF_BIRTH">
        <xsl:value-of select="//PID/PID.7"/>
      </xsl:element>
      <!-- PID.8 - Administrative Sex -->
      <!--  0001 - Administrative Sex :
            A(Ambiguous), F(Female), M(Male), N(Not applicable), O(Other), U(Unknown) -->
      <xsl:element name="ADMINISTRATIVE_SEX">
        <xsl:choose>
          <xsl:when test="//PID/PID.8='M' or //PID/PID.8='F'">
            <xsl:value-of select="//PID/PID.8"/>
          </xsl:when>
          <xsl:otherwise>O</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- PID.10 - Race -->
      <!--  0005 - Race :
            1002-5(American Indian or Alaska Native), 2028-9(Asian), 2054-5(Black or African American),
            2076-8(Native Hawaiian or Other Pacific Islander), 2106-3(White), 2131-1(Other Race) -->
      <xsl:element name="RACE">
        <xsl:choose>
          <xsl:when test="//PID/PID.10/PID.10.1 = 'WH'">2106-3</xsl:when>
          <xsl:when test="//PID/PID.10/PID.10.1 = 'AP'">2028-9</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//PID/PID.10/PID.10.1"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- PID.11 - Patient Address -->
      <xsl:element name="ADDRESS">
        <xsl:value-of select="//PID/PID.11/PID.11.1"/>
        <xsl:if test="string-length(//PID/PID.11/PID.11.3) > 0">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="//PID/PID.11/PID.11.3"/>
        </xsl:if>
        <xsl:if test="string-length(//PID/PID.11/PID.11.4) > 0">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="//PID/PID.11/PID.11.4"/>
        </xsl:if>
        <xsl:if test="string-length(//PID/PID.11/PID.11.5) > 0">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="//PID/PID.11/PID.11.5"/>
        </xsl:if>
        <xsl:if test="string-length(//PID/PID.11/PID.11.6) > 0">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="//PID/PID.11/PID.11.6"/>
        </xsl:if>
      </xsl:element>
      <xsl:element name="ADDRESS_CITY">
        <xsl:value-of select="//PID/PID.11/PID.11.3"/>
      </xsl:element>
      <xsl:element name="ADDRESS_STATE">
        <xsl:value-of select="//PID/PID.11/PID.11.4"/>
      </xsl:element>
      <xsl:element name="ADDRESS_ZIP_OR_POSTAL_CODE">
        <xsl:value-of select="//PID/PID.11/PID.11.5"/>
      </xsl:element>
      <xsl:element name="ADDRESS_COUNTRY">
        <xsl:value-of select="//PID/PID.11/PID.11.6"/>
      </xsl:element>
      <!-- PID.13 - Phone Number - Home -->
      <xsl:element name="PHONE_NUMBER_HOME">
        <xsl:value-of select="//PID/PID.13"/>
      </xsl:element>
      <!-- PID.14 - Phone Number - Business -->
      <xsl:element name="PHONE_NUMBER_BUSINESS">
        <xsl:value-of select="//PID/PID.14"/>
      </xsl:element>
      <!-- PID.15 - Primary Language -->
      <xsl:element name="PRIMARY_LANGUAGE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.15"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.16 - Marital Status -->
      <!--  0002 - Marital Status :
            A(Separated), B(Unmarried), C(Common law), D(Divorced), E(Legally Separated),
            G(Living together), I(Interlocutory), M(Married), N(Annulled), O(Other),
            P(Domestic partner), R(Registered domestic partner), S(Single), T(Unreported), U(Unknown),
            W(Widowed) -->
      <xsl:element name="MARITAL_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.16"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.17 - Religion -->
      <!--  0006 - Religion :
            ABC(Christian: American Baptist Church), AGN(Agnostic), AME(Christian: African Methodist Episcopal Zion), AMT(Christian: African Methodist Episcopal), ANG(Christian: Anglican),
            AOG(Christian: Assembly of God), ATH(Atheist), BAH(Baha'i), BAP(Christian: Baptist), BMA(Buddhist: Mahayana),
            BOT(Buddhist: Other), BTA(Buddhist: Tantrayana), BTH(Buddhist: Theravada), BUD(Buddhist), CAT(Christian: Roman Catholic),
            CFR(Chinese Folk Religionist), CHR(Christian), CHS(Christian: Christian Science), CMA(Christian: Christian Missionary Alliance), CNF(Confucian),
            COC(Christian: Church of Christ), COG(Christian: Church of God), COI(Christian: Church of God in Christ), COL(Christian: Congregational), COM(Christian: Community),
            COP(Christian: Other Pentecostal), COT(Christian: Other), CRR(Christian: Christian Reformed), EOT(Christian: Eastern Orthodox), EPI(Christian: Episcopalian),
            ERL(Ethnic Religionist), EVC(Christian: Evangelical Church), FRQ(Christian: Friends), FWB(Christian: Free Will Baptist), GRE(Christian: Greek Orthodox),
            HIN(Hindu), HOT(Hindu: Other), HSH(Hindu: Shaivites), HVA(Hindu: Vaishnavites), JAI(Jain),
            JCO(Jewish: Conservative), JEW(Jewish), JOR(Jewish: Orthodox), JOT(Jewish: Other), JRC(Jewish: Reconstructionist),
            JRF(Jewish: Reform), JRN(Jewish: Renewal), JWN(Christian: Jehovah's Witness), LMS(Christian: Lutheran Missouri Synod), LUT(Christian: Lutheran),
            MEN(Christian: Mennonite), MET(Christian: Methodist), MOM(Christian: Latter-day Saints), MOS(Muslim), MOT(Muslim: Other),
            MSH(Muslim: Shiite), MSU(Muslim: Sunni), NAM(Native American), NAZ(Christian: Church of the Nazarene), NOE(Nonreligious),
            NRL(New Religionist), ORT(Christian: Orthodox), OTH(Other), PEN(Christian: Pentecostal), PRC(Christian: Other Protestant),
            PRE(Christian: Presbyterian), PRO(Christian: Protestant), QUA(Christian: Friends), REC(Christian: Reformed Church), REO(Christian: Reorganized Church of Jesus Christ-LDS),
            SAA(Christian: Salvation Army), SEV(Christian: Seventh Day Adventist), SHN(Shintoist), SIK(Sikh), SOU(Christian: Southern Baptist),
            SPI(Spiritist), UCC(Christian: United Church of Christ), UMD(Christian: United Methodist), UNI(Christian: Unitarian), UNU(Christian: Unitarian Universalist),
            VAR(Unknown), WES(Christian: Wesleyan), WMC(Christian: Wesleyan Methodist) -->
      <xsl:element name="RELIGION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.17"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.18 - Patient Account Number -->
      <xsl:element name="ACCOUNT_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.18"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.19 - SSN Number - Patient -->
      <xsl:element name="SSN">
        <xsl:value-of select="//PID/PID.19"/>
      </xsl:element>
      <!-- PID.23 - Birth Place -->
      <xsl:element name="BIRTH_PLACE">
        <xsl:value-of select="//PID/PID.23"/>
      </xsl:element>
      <!-- PID.24 - Multiple Birth Indicator -->
      <!--  0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="MULTIPLE_BIRTH_INDICATOR">
        <xsl:value-of select="//PID/PID.24"/>
      </xsl:element>
      <!-- PID.25 - Birth Order -->
      <xsl:element name="BIRTH_ORDER">
        <xsl:value-of select="//PID/PID.25"/>
      </xsl:element>
      <!-- PID.26 - Citizenship -->
      <xsl:element name="CITIZENSHIP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.26"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.29 - Patient Death Date and Time -->
      <xsl:element name="DEATH_DTTM">
        <xsl:value-of select="//PID/PID.29"/>
      </xsl:element>
      <!-- PID.35 - Species Code -->
      <xsl:element name="SPECIES_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.35"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PID.36 - Breed Code -->
      <xsl:element name="BREED_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PID/PID.36"/>
        </xsl:call-template>
      </xsl:element>
      <!-- User define -->
      <xsl:element name="CONFIDENTIALITY"/>
      <xsl:element name="SIZE"/>
      <xsl:element name="WEIGHT"/>
      <xsl:element name="BLOOD_TYPE_ABO"/>
      <xsl:element name="BLOOD_TYPE_RH"/>
      <xsl:element name="OCCUPATION"/>
      <xsl:element name="EMAIL"/>
      <xsl:element name="PREGNANCY_CODE"/>
      <xsl:element name="PREGNANCY_STATUS"/>
      <xsl:element name="PATIENT_STATUS"/>
      <xsl:element name="CONTACT_TYPE">H</xsl:element>
      <xsl:element name="FAX_NUMBER"/>
      <xsl:element name="INSTITUTION_CODE"/>
      <xsl:element name="ADMIT_ROUTE"/>
      <xsl:element name="LASTMEN_STRUAL_DTTM"/>
      <xsl:element name="CODE_ABBREVIATION"/>
      <xsl:element name="STATION_CODE"/>
      <xsl:element name="ENGLISH_NAME"/>
      <xsl:element name="ETHNIC_GROUP"/>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - PV1 : Patient Visit											                                -->
  <!-- ================================================================================== -->
  <xsl:template name="PV1">
    <xsl:element name="PV1">
      <!-- PV1.2 - Patient Class -->
      <!--  0004 - Patient Class :
            B(Obstetrics), C(Commercial Account), E(Emergency), I(Inpatient), N(Not Applicable),
            O(Outpatient), P(Preadmit), R(Recurring patient), U(Unknown) -->
      <xsl:element name="PATIENT_CLASS">
        <xsl:value-of select="//PV1/PV1.2"/>
      </xsl:element>
      <!-- PV1.3 - Assigned Patient Location -->
      <xsl:element name="ASSIGNED_PATIENT_LOCATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PV1/PV1.3"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'\'"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="ASSIGNED_PATIENT_LOCATION_FACILITY">
        <xsl:value-of select="//PV1/PV1.3/PV1.3.4"/>
      </xsl:element>
      <!-- PV1.7 - Attending Doctor -->
      <xsl:element name="ATTENDING_DOCTOR_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PV1/PV1.7"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PV1.8 - Referring Doctor -->
      <xsl:element name="REFERRING_DOCTOR_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PV1/PV1.8"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="REFERRING_DOCTOR_NAME">
        <xsl:value-of select="//PV1/PV1.8/PV1.8.2"/>^<xsl:value-of select="//PV1/PV1.8/PV1.8.3"/>^<xsl:value-of select="//PV1/PV1.8/PV1.8.4"/>^<xsl:value-of select="//PV1/PV1.8/PV1.8.5"/>^<xsl:value-of select="//PV1/PV1.8/PV1.8.6"/>
      </xsl:element>
      <!-- PV1.9 - Consulting Doctor -->
      <xsl:element name="CONSULTING_DOCTOR_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PV1/PV1.9"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="CONSULTING_DOCTOR_NAME">
        <xsl:value-of select="//PV1/PV1.9/PV1.9.2"/>^<xsl:value-of select="//PV1/PV1.9/PV1.9.3"/>^<xsl:value-of select="//PV1/PV1.9/PV1.9.4"/>^<xsl:value-of select="//PV1/PV1.9/PV1.9.5"/>^<xsl:value-of select="//PV1/PV1.9/PV1.9.6"/>
      </xsl:element>
      <!-- PV1.19 - Visit Number -->
      <xsl:element name="VISIT_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//PV1/PV1.19"/>
        </xsl:call-template>
      </xsl:element>
      <!-- PV1.44 - Admit Date/Time (Reserve Date)-->
      <xsl:element name="ADMIT_DTTM">
        <xsl:choose>
          <xsl:when test="string-length(//PV1/PV1.44) &gt;= 4">
            <xsl:value-of select="//PV1/PV1.44"/>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
      <!-- PV1.45 - Discharge Date/Time -->
      <xsl:element name="DISCHARGE_DTTM">
        <xsl:choose>
          <xsl:when test="string-length(//PV1/PV1.45) &gt;= 4">
            <xsl:value-of select="//PV1/PV1.45"/>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
      <!-- User define -->
      <xsl:element name="VISIT_COMMENT"/>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - MRG : Merge Patient Information					                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MRG">
    <xsl:element name="MRG">
      <!-- MRG.1 - Prior Patient Identifier List -->
      <xsl:element name="MERGEE_PATIENT_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MRG/MRG.1"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - DG1 : Diagnosis                                                          -->
  <!-- ================================================================================== -->
  <xsl:template name="DG1">
    <xsl:element name="DG1">
      <!-- DG1.3 - Diagnosis Code -->
      <xsl:element name="DIAGNOSIS_CODE_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//DG1[position()=1]/DG1.3"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="DIAGNOSIS_CODE_TEXT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//DG1[position()=1]/DG1.3/DG1.3.2"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - SCH : Schedule activity information                                      -->
  <!-- ================================================================================== -->
  <xsl:template name="SCH">
    <xsl:element name="SCH">
      <!-- SCH.1 - Placer Appointment ID -->
      <xsl:element name="PLACER_APPOINTMENT_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//SCH/SCH.1/SCH.1.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- SCH.2 - Filler Appointment ID -->
      <xsl:element name="FILLER_APPOINTMENT_ID">
      </xsl:element>
      <!-- SCH.3 - Occurrence Number -->
      <xsl:element name="OCCURRENCE_NUMBER">
      </xsl:element>
      <!-- SCH.4 - Placer Group Number -->
      <xsl:element name="PLACER_GROUP_NUMBER">
      </xsl:element>
      <!-- SCH.5 - Schedule ID -->
      <xsl:element name="SCHEDULE_ID">
      </xsl:element>
      <!-- SCH.6 - Event Reason -->
      <xsl:element name="EVENT_REASON_IDENTIFIER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//SCH/SCH.6/SCH.6.1"/>
        </xsl:call-template>
            </xsl:element>
      <xsl:element name="EVENT_REASON_TEXT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//SCH/SCH.6/SCH.6.2"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="EVENT_REASON_NAME_OF_CODING_SYSTEM">
        <xsl:choose>
          <xsl:when test="string-length(//SCH/SCH.6/SCH.6.3) > 0">
            <xsl:call-template name="GetValue">
              <xsl:with-param name="path" select="//SCH/SCH.6/SCH.6.3"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>CPT</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- SCH.7 - Appointment Reason -->
      <xsl:element name="APPOINTMENT_REASON_TEXT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//SCH/SCH.7/SCH.7.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- SCH.8 - Appointment Type -->
      <xsl:element name="APPOINTMENT_TYPE">
      </xsl:element>
      <!-- SCH.9 - Appointment Duration -->
      <xsl:element name="APPOINTMENT_DURATION">
      </xsl:element>
      <!-- SCH.10 - Appointment Duration Units -->
      <xsl:element name="APPOINTMENT_DURATION_UNITS">
      </xsl:element>
      <!-- SCH.11 - Appointment Timing Quantity -->
      <xsl:element name="APPOINTMENT_TIMING_QUANTITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//SCH/SCH.11/SCH.11.4/SCH.11.4.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- SCH.12 - Placer Contact Person -->
      <xsl:element name="PLACER_CONTACT_PERSON">
      </xsl:element>
      <!-- SCH.13 - Placer Contact Phone Number -->
      <xsl:element name="PLACER_CONTACT_PHONE_NUMBER">
      </xsl:element>
      <!-- SCH.14 - Placer Contact Address -->
      <xsl:element name="PLACER_CONTACT_ADDRESS">
      </xsl:element>
      <!-- SCH.15 - Placer Contact Location -->
      <xsl:element name="PLACER_CONTACT_LOCATION">
      </xsl:element>
      <!-- SCH.16 - Filler Contact Person -->
      <xsl:element name="FILLER_CONTACT_PERSON">
      </xsl:element>
      <!-- SCH.17 - Filler Contact Phone Number -->
      <xsl:element name="FILLER_CONTACT_PHONE_NUMBER">
      </xsl:element>
      <!-- SCH.18 - Filler Contact Address -->
      <xsl:element name="FILLER_CONTACT_ADDRESS">
      </xsl:element>
      <!-- SCH.19 - Filler Contact Location -->
      <xsl:element name="FILLER_CONTACT_LOCATION">
      </xsl:element>
      <!-- SCH.20 - Entered by Person -->
      <xsl:element name="ENTERED_BY_PERSON">
      </xsl:element>
      <!-- SCH.21 - Entered by Phone Number -->
      <xsl:element name="ENTERED_BY_PHONE_NUMBER">
      </xsl:element>
      <!-- SCH.22 - Entered by Location -->
      <xsl:element name="ENTERED_BY_LOCATION">
      </xsl:element>
      <!-- SCH.23 - Parent Placer Appointment ID -->
      <xsl:element name="PARENT_PLACER_APPOINTMENT_ID">
      </xsl:element>
      <!-- SCH.24 - Parent Filler Appointment ID -->
      <xsl:element name="PARENT_FILLER_APPOINTMENT_ID">
      </xsl:element>
      <!-- SCH.25 - Filler Status Code -->
      <xsl:element name="FILLER_STATUS_CODE">
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - STF : Staff Identification								                                -->
  <!-- ================================================================================== -->
  <xsl:template name="STF">
    <xsl:element name="STF">
      <!-- STF.1 - Primary Key Value -->
      <xsl:element name="PRIMARY_KEY_VALUE_STF">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.2 - Staff Identifier List -->
      <xsl:element name="STAFF_ID_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.2/STF.2.1"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="STAFF_PASSWORD">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.2/STF.2.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.3 - Staff Name -->
      <xsl:element name="STAFF_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.3"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.4 - Staff Type -->
      <xsl:element name="STAFF_TYPE">
        <xsl:value-of select="//STF/STF.4"/>
      </xsl:element>
      <!-- STF.5 - Administrative Sex -->
      <!-- 0001 - Administrative Sex :
            A(Ambiguous), F(Female), M(Male), N(Not applicable), O(Other), U(Unknown) -->
      <xsl:element name="ADMINISTRATIVE_SEX">
        <xsl:value-of select="//STF/STF.5"/>
      </xsl:element>
      <!-- STF.6 - Date/Time of Birth -->
      <xsl:element name="DTTM_OF_BIRTH">
        <xsl:value-of select="//STF/STF.6"/>
      </xsl:element>
      <!-- STF.7 - Active/Inactive Flag -->
      <!-- 0183 - Active/Inactive :
            A(Active Staff), I(Inactive Staff) -->
      <xsl:element name="ACTIVE_INACTIVE_FLAG">
        <xsl:value-of select="//STF/STF.7"/>
      </xsl:element>
      <!-- STF.8 - Department -->
      <xsl:element name="DEPARTMENT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.8"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.9 - Hospital Service -->
      <!-- 0069 - Hospital Service :
            CAR(Cardiac Service), MED(Medical Service), PUL(Pulmonary Service), SUR(Surgical Service), URO(Urology Service) -->
      <xsl:element name="HOSPITAL_SERVICE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.9"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.10 - Phone -->
      <xsl:element name="PHONE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.10"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.11 - Office/Home Address/Birthplace -->
      <xsl:element name="OFFICE_HOME_ADDRESS">
        <xsl:value-of select="//STF/STF.11"/>
      </xsl:element>
      <!-- STF.12 - Institution Activation Date -->
      <xsl:element name="INSTITUTION_ACTIVATION_DATE">
        <xsl:value-of select="//STF/STF.12"/>
      </xsl:element>
      <!-- STF.13 - Institution Inactivation Date -->
      <xsl:element name="INSTITUTION_INACTIVATION_DATE">
        <xsl:value-of select="//STF/STF.13"/>
      </xsl:element>
      <!-- STF.14 - Backup Person ID -->
      <xsl:element name="BACKUP_PERSON_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.14"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.15 - E-Mail Address -->
      <xsl:element name="E_MAIL_ADDRESS">
        <xsl:value-of select="//STF/STF.15"/>
      </xsl:element>
      <!-- STF.16 - Preferred Method of Contact -->
      <!-- 0185 - Preferred method of contact :
            B(Beeper Number), C(Cellular Phone Number), E(E-Mail Address (for backward compatibility)), F(FAX Number), H(Home Phone Number),
            O(Office Phone Number) -->
      <xsl:element name="PREFERRED_METHOD_OF_CONTACT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.16"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.17 - Marital Status -->
      <!-- 0002 - Marital Status :
            A(Separated), B(Unmarried), C(Common law), D(Divorced), E(Legally Separated),
            G(Living together), I(Interlocutory), M(Married), N(Annulled), O(Other),
            P(Domestic partner), R(Registered domestic partner), S(Single), T(Unreported), U(Unknown),
            W(Widowed) -->
      <xsl:element name="MARITAL_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.17"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.18 - Job Title -->
      <xsl:element name="JOB_TITLE">
        <xsl:value-of select="//STF/STF.18"/>
      </xsl:element>
      <!-- STF.19 - Job Code/Class -->
      <xsl:element name="JOB_CODE_OR_CLASS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.19"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.20 - Employment Status Code -->
      <!-- 0066 - Employment Status - Employment Status :
            1(Full time employed), 2(Part time employed), 3(Unemployed), 4(Self-employed,), 5(Retired),
            6(On active military duty), 9(Unknown), C(Contract, per diem), L(Leave of absence (e.g. Family leave, sabbatical, etc.)),
            O(Other), T(Temporarily unemployed) -->
      <xsl:element name="EMPLOYMENT_STATUS_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.20"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.21 - Additional Insured on Auto -->
      <!-- 0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="ADDITIONAL_INSURED_ON_AUTO">
        <xsl:value-of select="//STF/STF.21"/>
      </xsl:element>
      <!-- STF.22 - Driver's License Number -->
      <xsl:element name="DRIVERS_LICENSE_NUMBER_STAFF">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.22"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.23 - Copy Auto Ins -->
      <!-- 0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="COPY_AUTO_INS">
        <xsl:value-of select="//STF/STF.23"/>
      </xsl:element>
      <!-- STF.24 - Auto Ins. Expires -->
      <xsl:element name="AUTO_INS_EXPIRES">
        <xsl:value-of select="//STF/STF.24"/>
      </xsl:element>
      <!-- STF.25 - Date Last DMV Review -->
      <xsl:element name="DATE_LAST_DMV_REVIEW">
        <xsl:value-of select="//STF/STF.25"/>
      </xsl:element>
      <!-- STF.26 - Date Next DMV Review -->
      <xsl:element name="DATE_NEXT_DMV_REVIEW">
        <xsl:value-of select="//STF/STF.26"/>
      </xsl:element>
      <!-- STF.27 - Race -->
      <!-- 0005 - Race :
            1002-5(American Indian or Alaska Native), 2028-9(Asian), 2054-5(Black or African American),
            2076-8(Native Hawaiian or Other Pacific Islander), 2106-3(White), 2131-1(Other Race) -->
      <xsl:element name="RACE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.27"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.28 - Ethnic Group -->
      <!-- 0189 - Ethnic Group :
            H(Hispanic or Latino), N(Not Hispanic or Latino), U(Unknown) -->
      <xsl:element name="ETHNIC_GROUP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//STF/STF.28"/>
        </xsl:call-template>
      </xsl:element>
      <!-- STF.29 - Re-activation Approval Indicator -->
      <!-- 0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="RE_ACTIVATION_APPROVAL_INDICATOR">
        <xsl:value-of select="//STF/STF.29"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - OBR : Observation Request 																                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBR">
    <xsl:element name="OBR">
      <!-- OBR.4 - Universal Service Identifier -->
      <xsl:element name="UNIVERSAL_SERVICE_IDENTIFIER_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.4"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="UNIVERSAL_SERVICE_IDENTIFIER_TEXT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.4/OBR.4.2"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="NAME_OF_CODING_SYSTEM">
        <xsl:choose>
          <xsl:when test="string-length(//OBR[position()=1]/OBR.4/OBR.4.3) > 0">
            <xsl:call-template name="GetValue">
              <xsl:with-param name="path" select="//OBR[position()=1]/OBR.4/OBR.4.3"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>CPT</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- ACCESSION_NUMBER -->
      <xsl:element name="ACCESSION_NUMBER">
        <xsl:choose>
          <xsl:when test="string-length(//OBR[position()=1]/OBR.18) > 0">
            <xsl:call-template name="GetValue">
              <!-- OBR.18 - Placer Field 1 -->
              <xsl:with-param name="path" select="//OBR[position()=1]/OBR.18"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="GetValue">
              <!-- OBR.2 - Placer Order Number -->
              <xsl:with-param name="path" select="//OBR[position()=1]/OBR.2"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- OBR.2 - Placer Order Number -->
      <xsl:element name="PLACER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.3 - Filler Order Number -->
      <xsl:element name="FILLER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.5 - Priority -->
      <xsl:element name="PRIORITY">
        <xsl:value-of select="//OBR[position()=1]/OBR.5"/>
      </xsl:element>
      <!-- OBR.13 - Relevant Clinical Information (OrderComments) -->
      <xsl:element name="RELEVANT_CLINICAL_INFORMATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.13"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.18 - Placer Field 1 -->
      <xsl:element name="PLACER_FIELD_1">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.18"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.22 - Results Rpt/Status Chng - Date/Time -->
      <xsl:element name="RESULTS_REPORT_STATUS_CHANGE_DTTM">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.22"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.24 - Diagnostic Serv Sect ID (OrderDepartment) -->
      <!--  0074 - Diagnostic Service Section ID :
            AU(Audiology), BG(Blood Gases), BLB(Blood Bank), CH(Chemistry), CP(Cytopathology),
            CT(CAT Scan), CTH(Cardiac Catheterization), CUS(Cardiac Ultrasound), EC(Electrocardiac (e.g., EKG,  EEC, Holter)), EN(Electroneuro (EEG, EMG,EP,PSG)),
            HM(Hematology), ICU(Bedside ICU Monitoring), IMM(Immunology), LAB(Laboratory), MB(Microbiology),
            MCB(Mycobacteriology), MYC(Mycology), NMR(Nuclear Magnetic Resonance), NMS(Nuclear Medicine Scan), NRS(Nursing Service Measures),
            OSL(Outside Lab), OT(Occupational Therapy), OTH(Other), OUS(OB Ultrasound), PF(Pulmonary Function),
            PHR(Pharmacy), PHY(Physician (Hx. Dx, admission note, etc.)), PT(Physical Therapy), RAD(Radiology), RC(Respiratory Care (therapy)),
            RT(Radiation Therapy), RUS(Radiology Ultrasound), RX(Radiograph), SP(Surgical Pathology), SR(Serology),
            TX(Toxicology), VR(Virology), VUS(Vascular Ultrasound), XRC(Cineradiograph) -->
      <xsl:element name="DIAGNOSTIC_SERV_SECT_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.24"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.31 - Reason for Study (OrderReason) -->
      <xsl:element name="REASON_FOR_STUDY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.31/OBR.31.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.32 - Principal Result Interpreter -->
      <xsl:element name="PRINCIPAL_RESULT_INTERPRETER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.32"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.36 - Scheduled Date/Time (OrderDttm) -->
      <xsl:element name="SCHEDULED_DTTM">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBR[position()=1]/OBR.36"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBR.41 - Transport Arranged -->
      <!--  0224 - Transport Arranged :
            A(Arranged), N(Not Arranged), U(Unknown)-->
      <xsl:element name="TRANSPORT_ARRANGED">
        <xsl:value-of select="//OBR[position()=1]/OBR.41"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - MFI : Master File Identification    			                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MFI">
    <xsl:element name="MFI">
      <!-- MFI.1 - Master File Identifier -->
      <!--  0175 - Master file identifier code :
            CDM(Charge description master file), CLN(Clinic master file), CMA(Clinical study with phases and scheduled master file),
            CMB(Clinical study without phases but with scheduled master file), INV(Inventory master file), LOC(Location master file),
            OMA(Numerical observation master file), OMB(Categorical observation master file), OMC(Observation batteries master file),
            OMD(Calculated observations master file), OME(Other Observation/Service Item master file), PRA(Practitioner master file),
            STF(Staff master file) -->
      <xsl:element name="MASTER_FILE_IDENTIFIER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MFI/MFI.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MFI.2 - Master File Application Identifier -->
      <xsl:element name="MASTER_FILE_APPLICATION_IDENTIFIER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//MFI/MFI.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- MFI.3 - File-Level Event Code -->
      <!--  0178 - File level event code :
            REP(Replace current version of this master file with the version contained in this message),
            UPD(Change file records as defined in the record-level event codes for each record that follows) -->
      <xsl:element name="FILE_LEVEL_EVENT_CODE">
        <xsl:value-of select="//MFI/MFI.3"/>
      </xsl:element>
      <!-- MFI.4 - Entered Date/Time -->
      <xsl:element name="ENTERED_DTTM">
        <xsl:value-of select="//MFI/MFI.4"/>
      </xsl:element>
      <!-- MFI.5 - Effective Date/Time -->
      <xsl:element name="EFFECTIVE_DTTM">
        <xsl:value-of select="//MFI/MFI.5"/>
      </xsl:element>
      <!-- MFI.6 - Response Level Code -->
      <!--  0179 - Response level :
            AL(Always.  All MFA segments (whether denoting errors or not) must be returned via the application-level acknowledgment message),
            ER(Error/Reject conditions only.  Only MFA segments denoting errors must be returned via the application-level acknowledgment for this message),
            NE(Never.  No application-level response needed),
            SU(Success.  Only MFA segments denoting success must be returned via the application-level acknowledgment for this message) -->
      <xsl:element name="RESPONSE_LEVEL_CODE">
        <xsl:value-of select="//MFI/MFI.6"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - MFE : Master File Entry									                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MFE">
    <xsl:element name="MFE">
      <!-- MFE.1 - Record-Level Event Code -->
      <!--  0180 - Record-level event code :
            MAC(Reactivate deactivated record), MAD(Add record to master file),
            MDC(Deactivate: discontinue using record in master file, but do not delete from database),
            MDL(Delete record from master file), MUP(Update record for master file) -->
      <xsl:element name="RECORD_LEVEL_EVENT_CODE">
        <xsl:value-of select="//MFE/MFE.1"/>
      </xsl:element>
      <!-- MFE.2 - MFN Control ID -->
      <xsl:element name="MFN_CONTROL_ID">
        <xsl:value-of select="//MFE/MFE.2"/>
      </xsl:element>
      <!-- MFE.3 - Effective Date/Time -->
      <xsl:element name="EFFECTIVE_DTTM">
        <xsl:value-of select="//MFE/MFE.3"/>
      </xsl:element>
      <!-- MFE.4 - Primary Key Value -->
      <xsl:element name="PRIMARY_KEY_VALUE_MFE">
        <xsl:value-of select="//MFE/MFE.4"/>
      </xsl:element>
      <!-- MFE.5 - Primary Key Value Type -->
      <!--  0355 - Primary key value type :
            CE(Coded element), PL(Person location) -->
      <xsl:element name="PRIMARY_KEY_VALUE_TYPE">
        <xsl:value-of select="//MFE/MFE.5"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - GT1 : Guarantor													                                -->
  <!-- ================================================================================== -->
  <xsl:template name="GT1">
    <xsl:element name="GT1">
      <!-- GT1.1 - Set ID -->
      <xsl:element name="SET_ID">
        <xsl:value-of select="//GT1/GT1.1"/>
      </xsl:element>
      <!-- GT1.2 - Guarantor Number -->
      <xsl:element name="GUARANTOR_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.3 - Guarantor Name -->
      <xsl:element name="GUARANTOR_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.3"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.4 - Guarantor Spouse Name -->
      <xsl:element name="GUARANTOR_SPOUSE_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.4"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.5 - Guarantor Address -->
      <xsl:element name="GUARANTOR_ADDRESS">
        <xsl:value-of select="//GT1/GT1.5"/>
      </xsl:element>
      <!-- GT1.6 - Guarantor Ph Num - Home -->
      <xsl:element name="GUARANTOR_PH_NUM_HOME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.6"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.7 - Guarantor Ph Num - Business -->
      <xsl:element name="GUARANTOR_PH_NUM_BUSINESS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.7"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.8 - Guarantor Date/Time Of Birth -->
      <xsl:element name="GUARANTOR_DTTM_OF_BIRTH">
        <xsl:value-of select="//GT1/GT1.8"/>
      </xsl:element>
      <!-- GT1.9 - Guarantor Administrative Sex -->
      <!--  0001 - Administrative Sex :
            A(Ambiguous), F(Female), M(Male), N(Not applicable), O(Other), U(Unknown) -->
      <xsl:element name="GUARANTOR_ADMINISTRATIVE_SEX">
        <xsl:value-of select="//GT1/GT1.9"/>
      </xsl:element>
      <!-- GT1.10 - Guarantor Type -->
      <xsl:element name="GUARANTOR_TYPE">
        <xsl:value-of select="//GT1/GT1.10"/>
      </xsl:element>
      <!-- GT1.11 - Guarantor Relationship -->
      <!--  0063 - Relationship :
            ASC(Associate), BRO(Brother), CGV(Care giver), CHD(Child), DEP(Handicapped dependent),
            DOM(Life partner), EMC(Emergency contact), EME(Employee), EMR(Employer), EXF(Extended family),
            FCH(Foster child), FND(Friend), FTH(Father), GCH(Grandchild), GRD(Guardian),
            GRP(Grandparent), MGR(Manager), MTH(Mother), NCH(Natural child), NON(None),
            OAD(Other adult), OTH(Other), OWN(Owner), PAR(Parent), SCH(Stepchild),
            SEL(Self), SIB(Sibling), SIS(Sister), SPO(Spouse), TRA(Trainer), UNK(Unknown),
            WRD(Ward of court) -->
      <xsl:element name="GUARANTOR_RELATIONSHIP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.11"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.12 - Guarantor SSN -->
      <xsl:element name="GUARANTOR_SSN">
        <xsl:value-of select="//GT1/GT1.12"/>
      </xsl:element>
      <!-- GT1.13 - Guarantor Date - Begin -->
      <xsl:element name="GUARANTOR_DATE_BEGIN">
        <xsl:value-of select="//GT1/GT1.13"/>
      </xsl:element>
      <!-- GT1.14 - Guarantor Date - End -->
      <xsl:element name="GUARANTOR_DATE_END">
        <xsl:value-of select="//GT1/GT1.14"/>
      </xsl:element>
      <!-- GT1.15 - Guarantor Priority -->
      <xsl:element name="GUARANTOR_PRIORITY">
        <xsl:value-of select="//GT1/GT1.15"/>
      </xsl:element>
      <!-- GT1.16 - Guarantor Employer Name -->
      <xsl:element name="GUARANTOR_EMPLOYER_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.16"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.17 - Guarantor Employer Address -->
      <xsl:element name="GUARANTOR_EMPLOYER_ADDRESS">
        <xsl:value-of select="//GT1/GT1.17"/>
      </xsl:element>
      <!-- GT1.18 - Guarantor Employer Phone Number -->
      <xsl:element name="GUARANTOR_EMPLOYER_PHONE_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.18"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.19 - Guarantor Employee ID Number -->
      <xsl:element name="GUARANTOR_EMPLOYEE_ID_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.19"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.20 - Guarantor Employment Status -->
      <!--  0066 - Employment Status :
            1(Full time employed), 2(Part time employed), 3(Unemployed), 4(Self-employed,), 5(Retired),
            6(On active military duty), 9(Unknown), C(Contract, per diem), L(Leave of absence (e.g. Family leave, sabbatical, etc.)),
            O(Other), T(Temporarily unemployed) -->
      <xsl:element name="GUARANTOR_EMPLOYMENT_STATUS">
        <xsl:value-of select="//GT1/GT1.20"/>
      </xsl:element>
      <!-- GT1.21 - Guarantor Organization Name -->
      <xsl:element name="GUARANTOR_ORGANIZATION_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.21"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.22 - Guarantor Billing Hold Flag -->
      <!--  0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="GUARANTOR_BILLING_HOLD_FLAG">
        <xsl:value-of select="//GT1/GT1.22"/>
      </xsl:element>
      <!-- GT1.23 - Guarantor Credit Rating Code -->
      <xsl:element name="GUARANTOR_CREDIT_RATING_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.23"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.24 - Guarantor Death Date And Time -->
      <xsl:element name="GUARANTOR_DEATH_DTTM">
        <xsl:value-of select="//GT1/GT1.24"/>
      </xsl:element>
      <!-- GT1.25 - Guarantor Death Flag -->
      <!--  0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="GUARANTOR_DEATH_FLAG">
        <xsl:value-of select="//GT1/GT1.25"/>
      </xsl:element>
      <!-- GT1.26 - Guarantor Charge Adjustment Code -->
      <xsl:element name="GUARANTOR_CHARGE_ADJUSTMENT_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.26"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.27 - Guarantor Household Annual Income -->
      <xsl:element name="GUARANTOR_HOUSEHOLD_ANNUAL_INCOME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.27"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.28 - Guarantor Household Size -->
      <xsl:element name="GUARANTOR_HOUSEHOLD_SIZE">
        <xsl:value-of select="//GT1/GT1.28"/>
      </xsl:element>
      <!-- GT1.29 - Guarantor Employer ID Number -->
      <xsl:element name="GUARANTOR_EMPLOYER_ID_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.29"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.30 - Guarantor Marital Status Code -->
      <!--  0002 - Marital Status :
            A(Separated), B(Unmarried), C(Common law), D(Divorced), E(Legally Separated),
            G(Living together), I(Interlocutory), M(Married), N(Annulled), O(Other),
            P(Domestic partner), R(Registered domestic partner), S(Single), T(Unreported), U(Unknown),
            W(Widowed) -->
      <xsl:element name="GUARANTOR_MARITAL_STATUS_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.30"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.31 - Guarantor Hire Effective Date -->
      <xsl:element name="GUARANTOR_HIRE_EFFECTIVE_DATE">
        <xsl:value-of select="//GT1/GT1.31"/>
      </xsl:element>
      <!-- GT1.32 - Employment Stop Date -->
      <xsl:element name="EMPLOYMENT_STOP_DATE">
        <xsl:value-of select="//GT1/GT1.32"/>
      </xsl:element>
      <!-- GT1.33 - Living Dependency -->
      <!--  0223 - Living Dependency
            C(Small Children Dependent), M(Medical Supervision Required), O(Other), S(Spouse Dependent), U(Unknown) -->
      <xsl:element name="LIVING_DEPENDENCY">
        <xsl:value-of select="//GT1/GT1.33"/>
      </xsl:element>
      <!-- GT1.34 - Ambulatory Status -->
      <!--  0009 - Ambulatory Status :
            A0(No functional limitations), A1(Ambulates with assistive device), A2(Wheelchair/stretcher bound), A3(Comatose; non-responsive), A4(Disoriented),
            A5(Vision impaired), A6(Hearing impaired), A7(Speech impaired), A8(Non-English speaking), A9(Functional level unknown),
            B1(Oxygen therapy), B2(Special equipment (tubes, IVs, catheters)), B3(Amputee), B4(Mastectomy), B5(Paraplegic),
            B6(Pregnant) -->
      <xsl:element name="AMBULATORY_STATUS">
        <xsl:value-of select="//GT1/GT1.34"/>
      </xsl:element>
      <!-- GT1.35 - Citizenship -->
      <xsl:element name="CITIZENSHIP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.35"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.36 - Primary Language -->
      <xsl:element name="PRIMARY_LANGUAGE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.36"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.37 - Living Arrangement -->
      <!--  0220 - Living Arrangement :
            A(Alone), F(Family), I(Institution), R(Relative), S(Spouse Only),
            U(Unknown) -->
      <xsl:element name="LIVING_ARRANGEMENT">
        <xsl:value-of select="//GT1/GT1.37"/>
      </xsl:element>
      <!-- GT1.38 - Publicity Code -->
      <!--  0215 - Publicity Code :
            F(Family only), N(No Publicity), O(Other), U(Unknown) -->
      <xsl:element name="PUBLICITY_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.38"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.39 - Protection Indicator -->
      <!--  0136 - Yes/no indicator :
            N(No), Y(Yes) -->
      <xsl:element name="PROTECTION_INDICATOR">
        <xsl:value-of select="//GT1/GT1.39"/>
      </xsl:element>
      <!-- GT1.40 - Student Indicator -->
      <!--  0231 - Student Status :
            F(Full-time student), N(Not a student), P(Part-time student) -->
      <xsl:element name="STUDENT_INDICATOR">
        <xsl:value-of select="//GT1/GT1.40"/>
      </xsl:element>
      <!-- GT1.41 - Religion -->
      <!--  0006 - Religion :
            ABC(Christian: American Baptist Church), AGN(Agnostic), AME(Christian: African Methodist Episcopal Zion), AMT(Christian: African Methodist Episcopal), ANG(Christian: Anglican),
            AOG(Christian: Assembly of God), ATH(Atheist), BAH(Baha'i), BAP(Christian: Baptist), BMA(Buddhist: Mahayana),
            BOT(Buddhist: Other), BTA(Buddhist: Tantrayana), BTH(Buddhist: Theravada), BUD(Buddhist), CAT(Christian: Roman Catholic),
            CFR(Chinese Folk Religionist), CHR(Christian), CHS(Christian: Christian Science), CMA(Christian: Christian Missionary Alliance), CNF(Confucian),
            COC(Christian: Church of Christ), COG(Christian: Church of God), COI(Christian: Church of God in Christ), COL(Christian: Congregational), COM(Christian: Community),
            COP(Christian: Other Pentecostal), COT(Christian: Other), CRR(Christian: Christian Reformed), EOT(Christian: Eastern Orthodox), EPI(Christian: Episcopalian),
            ERL(Ethnic Religionist), EVC(Christian: Evangelical Church), FRQ(Christian: Friends), FWB(Christian: Free Will Baptist), GRE(Christian: Greek Orthodox),
            HIN(Hindu), HOT(Hindu: Other), HSH(Hindu: Shaivites), HVA(Hindu: Vaishnavites), JAI(Jain),
            JCO(Jewish: Conservative), JEW(Jewish), JOR(Jewish: Orthodox), JOT(Jewish: Other), JRC(Jewish: Reconstructionist),
            JRF(Jewish: Reform), JRN(Jewish: Renewal), JWN(Christian: Jehovah's Witness), LMS(Christian: Lutheran Missouri Synod), LUT(Christian: Lutheran),
            MEN(Christian: Mennonite), MET(Christian: Methodist), MOM(Christian: Latter-day Saints), MOS(Muslim), MOT(Muslim: Other),
            MSH(Muslim: Shiite), MSU(Muslim: Sunni), NAM(Native American), NAZ(Christian: Church of the Nazarene), NOE(Nonreligious),
            NRL(New Religionist), ORT(Christian: Orthodox), OTH(Other), PEN(Christian: Pentecostal), PRC(Christian: Other Protestant),
            PRE(Christian: Presbyterian), PRO(Christian: Protestant), QUA(Christian: Friends), REC(Christian: Reformed Church), REO(Christian: Reorganized Church of Jesus Christ-LDS),
            SAA(Christian: Salvation Army), SEV(Christian: Seventh Day Adventist), SHN(Shintoist), SIK(Sikh), SOU(Christian: Southern Baptist),
            SPI(Spiritist), UCC(Christian: United Church of Christ), UMD(Christian: United Methodist), UNI(Christian: Unitarian), UNU(Christian: Unitarian Universalist),
            VAR(Unknown), WES(Christian: Wesleyan), WMC(Christian: Wesleyan Methodist) -->
      <xsl:element name="RELIGION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.41"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.42 - Mother's Maiden Name -->
      <xsl:element name="MOTHERS_MAIDEN_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.42"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.43 - Nationality -->
      <xsl:element name="NATIONALITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.43"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.44 - Ethnic Group -->
      <!--  0189 - Ethnic Group :
            H(Hispanic or Latino), N(Not Hispanic or Latino), U(Unknown) -->
      <xsl:element name="ETHNIC_GROUP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.44"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.45 - Contact Person's Name -->
      <xsl:element name="CONTACT_PERSONS_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.45"/>
          <xsl:with-param name="count" select="3"/>
          <xsl:with-param name="separator" select="'^'"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.46 - Contact Person's Telephone Number -->
      <xsl:element name="CONTACT_PERSONS_TELEPHONE_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.46"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.47 - Contact Reason -->
      <xsl:element name="CONTACT_REASON">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.47"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.48 - Contact Relationship -->
      <!--  0063 - Relationship :
            ASC(Associate), BRO(Brother), CGV(Care giver), CHD(Child), DEP(Handicapped dependent),
            DOM(Life partner), EMC(Emergency contact), EME(Employee), EMR(Employer), EXF(Extended family),
            FCH(Foster child), FND(Friend), FTH(Father), GCH(Grandchild), GRD(Guardian),
            GRP(Grandparent), MGR(Manager), MTH(Mother), NCH(Natural child), NON(None),
            OAD(Other adult), OTH(Other), OWN(Owner), PAR(Parent), SCH(Stepchild),
            SEL(Self), SIB(Sibling), SIS(Sister), SPO(Spouse), TRA(Trainer), UNK(Unknown),
            WRD(Ward of court) -->
      <xsl:element name="CONTACT_RELATIONSHIP">
        <xsl:value-of select="//GT1/GT1.48"/>
      </xsl:element>
      <!-- GT1.49 - Job Title -->
      <xsl:element name="JOB_TITLE">
        <xsl:value-of select="//GT1/GT1.49"/>
      </xsl:element>
      <!-- GT1.50 - Job Code/Class -->
      <xsl:element name="JOB_CODE_CLASS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.50"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.51 - Guarantor Employer's Organization Name -->
      <xsl:element name="GUARANTOR_EMPLOYERS_ORGANIZATION_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.51"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.52 - Handicap -->
      <xsl:element name="HANDICAP">
        <xsl:value-of select="//GT1/GT1.52"/>
      </xsl:element>
      <!-- GT1.53 - Job Status -->
      <!--  0311 - Job Status :
            O(Other), P(Permanent), T(Temporary), U(Unknown) -->
      <xsl:element name="JOB_STATUS">
        <xsl:value-of select="//GT1/GT1.53"/>
      </xsl:element>
      <!-- GT1.54 - Guarantor Financial Class -->
      <xsl:element name="GUARANTOR_FINANCIAL_CLASS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.54"/>
        </xsl:call-template>
      </xsl:element>
      <!-- GT1.55 - Guarantor Race -->
      <!--  0005 - Race :
            1002-5(American Indian or Alaska Native), 2028-9(Asian), 2054-5(Black or African American),
            2076-8(Native Hawaiian or Other Pacific Islander), 2106-3(White), 2131-1(Other Race) -->
      <xsl:element name="GUARANTOR_RACE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//GT1/GT1.55"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - AL1 : Patient Allergy Information				                                -->
  <!-- ================================================================================== -->
  <xsl:template name="AL1">
    <xsl:element name="AL1">
      <!-- AL1.1 - Set ID -->
      <xsl:element name="SET_ID">
        <xsl:value-of select="//AL1[position()=1]/AL1.1"/>
      </xsl:element>
      <!-- AL1.2 - Allergen Type Code -->
      <!--  0127 - Allergen Type :
            AA(Animal Allergy), DA(Drug allergy), EA(Environmental Allergy), FA(Food allergy), LA(Pollen Allergy),
            MA(Miscellaneous allergy), MC(Miscellaneous contraindication), PA(Plant Allergy) -->
      <xsl:element name="ALLERGY_TYPE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AL1[position()=1]/AL1.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- AL1.3 - Allergen Code/Mnemonic/Description -->
      <xsl:element name="ALLERGY_CODE_MNEMONIC_DESCRIPTION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AL1[position()=1]/AL1.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- AL1.4 - Allergy Severity Code -->
      <xsl:element name="ALLERGY_SEVERITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AL1[position()=1]/AL1.4"/>
        </xsl:call-template>
      </xsl:element>
      <!-- AL1.5 - Allergy Reaction Code -->
      <!--  0128 - Allergy Severity :
            MI(Mild), MO(Moderate), SV(Severe), U(Unknown) -->
      <xsl:element name="ALLERGY_REACTION">
        <xsl:value-of select="//AL1[position()=1]/AL1.5"/>
      </xsl:element>
      <!-- AL1.6 - Identification Date -->
      <xsl:element name="IDENTIFICATION_DATE">
        <xsl:value-of select="//AL1[position()=1]/AL1.6"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - ORC : Common Order					  						                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORC">
    <xsl:element name="ORC">
      <!-- ORC.1 - Order Control -->
      <!--  0119 - Order control codes :
            AF(Order/service refill request approval), CA(Cancel order/service request), CH(Child order/service), CN(Combined result), CR(Canceled as requested),
            DC(Discontinue order/service request), DE(Data errors), DF(Order/service refill request denied), DR(Discontinued as requested), FU(Order/service refilled, unsolicited),
            HD(Hold order request), HR(On hold as requested), LI(Link order/service to patient care problem or goal), NA(Number assigned), NW(New order/service),
            OC(Order/service canceled), OD(Order/service discontinued), OE(Order/service released), OF(Order/service refilled as requested), OH(Order/service held),
            OK(Order/service accepted & OK), OP(Notification of order for outside dispense), OR(Released as requested), PA(Parent order/service), PY(Notification of replacement order for outside dispense),
            RE(Observations/Performed Service to follow), RF(Refill order/service request), RL(Release previous hold), RO(Replacement order), RP(Order/service replace request),
            RQ(Replaced as requested), RR(Request received), RU(Replaced unsolicited), SC(Status changed), SN(Send order/service number),
            SR(Response to send order/service status request), SS(Send order/service status request), UA(Unable to accept order/service), UC(Unable to cancel), UD(Unable to discontinue),
            UF(Unable to refill), UH(Unable to put on hold), UM(Unable to replace), UN(Unlink order/service from patient care problem or goal), UR(Unable to release),
            UX(Unable to change), XO(Change order/service request), XR(Changed as requested), XX(Order/service changed, unsol.) -->
      <xsl:element name="ORDER_CONTROL">
        <xsl:value-of select="//ORC[position()=1]/ORC.1"/>
      </xsl:element>
      <!-- ORC.2 - Placer Order Number -->
      <xsl:element name="PLACER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.3 - Filler Order Number -->
      <xsl:element name="FILLER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.4 - Placer Group Number -->
      <xsl:element name="PLACER_GROUP_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.4"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.5 - Order Status -->
      <!--  0038 - Order status :
            A(Some, but not all, results available), CA(Order was canceled), CM(Order is completed),
            DC(Order was discontinued), ER(Error, order not found), HD(Order is on hold),
            IP(In process, unspecified), RP(Order has been replaced), SC(In process, scheduled) -->
      <xsl:element name="ORDER_STATUS">
        <xsl:choose>
          <xsl:when test="string-length(//ORC[position()=1]/ORC.5) > 0">
            <xsl:value-of select="//ORC[position()=1]/ORC.5"/>
          </xsl:when>
          <xsl:otherwise>SC</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- ORC.6 - Response Flag  -->
      <!--  0121 - Response flag
            D(Same as R, also other associated segments), E(Report exceptions only),
            F(Same as D, plus confirmations explicitly), N(Only the MSA segment is returned),
            R(Same as E, also Replacement and Parent-Child) -->
      <xsl:element name="RESPONSE_FLAG">
        <xsl:value-of select="//ORC[position()=1]/ORC.6"/>
      </xsl:element>
      <!-- ORC.7 - Quantity/Timing -->
      <xsl:element name="QUANTITY_TIMING">
        <xsl:value-of select="//ORC[position()=1]/ORC.7"/>
      </xsl:element>
      <!-- ORC.8 - Parent Order -->
      <xsl:element name="PARENT_ORDER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.8"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.9 - Date/Time of Transaction -->
      <xsl:element name="DTTM_OF_TRANSACTION">
        <xsl:value-of select="//ORC[position()=1]/ORC.9"/>
      </xsl:element>
      <!-- ORC.10 - Entered By -->
      <xsl:element name="ENTERED_BY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.10"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.11 - Verified By -->
      <xsl:element name="VERIFIED_BY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.11"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.12 - Ordering Provider -->
      <xsl:element name="ORDERING_PROVIDER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.12"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.13 - Enterer's Location -->
      <xsl:element name="ENTERERS_LOCATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.13"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.14 - Call Back Phone Number -->
      <xsl:element name="CALL_BACK_PHONE_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.14"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.15 - Order Effective Date/Time -->
      <xsl:element name="ORDER_EFFECTIVE_DTTM">
        <xsl:value-of select="//ORC[position()=1]/ORC.15"/>
      </xsl:element>
      <!-- ORC.16 - Order Control Code Reason -->
      <xsl:element name="ORDER_CONTROL_CODE_REASON">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.16"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.17 - Entering Organization -->
      <xsl:element name="ENTERING_ORGANIZATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.17"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.18 - Entering Device -->
      <xsl:element name="ENTERING_DEVICE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.18"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.19 - Action By -->
      <xsl:element name="ACTION_BY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.19"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.20 - Advanced Beneficiary Notice Code -->
      <!--  0339 - Advanced Beneficiary Notice Code :
            1(Service is subject to medical necessity procedures),
            2(Patient has been informed of responsibility, and agrees to pay for service),
            3(Patient has been informed of responsibility, and asks that the payer be billed),
            4(Advanced Beneficiary Notice has not been signed) -->
      <xsl:element name="ADVANCED_BENEFICIARY_NOTICE_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.20"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.21 - Ordering Facility Name -->
      <xsl:element name="ORDERING_FACILITY_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.21"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.22 - Ordering Facility Address -->
      <xsl:element name="ORDERING_FACILITY_ADDRESS">
        <xsl:value-of select="//ORC[position()=1]/ORC.22"/>
      </xsl:element>
      <!-- ORC.23 - Ordering Facility Phone Number -->
      <xsl:element name="ORDERING_FACILITY_PHONE_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//ORC[position()=1]/ORC.23"/>
        </xsl:call-template>
      </xsl:element>
      <!-- ORC.24 - Ordering Provider Address -->
      <xsl:element name="ORDERING_PROVIDER_ADDRESS">
        <xsl:value-of select="//ORC[position()=1]/ORC.24"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - OBX : Observation/Result  																                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBX">
    <xsl:element name="OBX">
      <!-- OBX.2 - Value Type -->
      <xsl:element name="VALUE_TYPE">
        <xsl:value-of select="//OBX[position()=1]//OBX.2"/>        
      </xsl:element>
      <!-- OBX.5 - Observation Value -->
      <xsl:element name="OBSERVATION_VALUE_TEXT">
        <xsl:if test="//OBX/OBX.2 = 'TX'">
          <xsl:apply-templates select="//OBX/OBX.5"/>
        </xsl:if>        
      </xsl:element>
      <xsl:element name="OBSERVATION_VALUE_FILE">
        <xsl:choose>
          <xsl:when test="//OBX/OBX.2 = 'ED'">
            <xsl:value-of select="//OBX/OBX.5/OBX.5.5"/>
          </xsl:when>
          <xsl:when test="//OBX/OBX.2 = 'RP'">
            <xsl:if test="string-length(//OBX/OBX.5) > 0">
              <xsl:value-of select="cs:Convert_ToBase64String(//OBX/OBX.5, 'utf-8')"/>
            </xsl:if>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.11 - Observation Result Status (Report Stat)-->
      <xsl:element name="OBSERVATION_RESULT_STATUS">
        <xsl:choose>
          <xsl:when test="//OBX[position()=1]/OBX.11='F'">240</xsl:when>
          <xsl:otherwise>230</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.14 - Date/Time of the Observation (CreateDttm, DictateDttm, TranscribeDttm) -->
      <xsl:element name="DTTM_OF_THE_OBSERVATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//OBX[position()=1]/OBX.14"/>
        </xsl:call-template>
      </xsl:element>
      <!-- OBX.16 - Responsible Observer -->
      <xsl:element name="RESPONSIBLE_OBSERVER">
        <xsl:element name="ID_NUMBER">
          <xsl:call-template name="GetValue">
            <xsl:with-param name="path" select="//OBX[position()=1]/OBX.16"/>
            <xsl:with-param name="count" select="1"/>
          </xsl:call-template>
        </xsl:element>
        <xsl:element name="NAME">
          <xsl:value-of select="//OBX[position()=1]/OBX.16/OBX.16.2"/>^<xsl:value-of select="//OBX[position()=1]/OBX.16/OBX.16.3"/>^<xsl:value-of select="//OBX[position()=1]/OBX.16/OBX.16.4"/>^<xsl:value-of select="//OBX[position()=1]/OBX.16/OBX.16.5"/>^<xsl:value-of select="//OBX[position()=1]/OBX.16/OBX.16.6"/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - NTE : Notes and Comments      						                                -->
  <!-- ================================================================================== -->
  <xsl:template name="NTE">
    <xsl:element name="NTE">
      <!-- NTE.1 - Set ID -->
      <xsl:element name="SET_ID">
        <xsl:value-of select="//NTE[position()=1]/NTE.1"/>
      </xsl:element>
      <!-- NTE.2 - Source of Comment -->
      <!--  0105 - Source of comment :
            L(Ancillary (filler) department is source of comment),
            O(Other system is source of comment),
            P(Orderer (placer) is source of comment) -->
      <xsl:element name="SOURCE_OF_COMMENT">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//NTE[position()=1]/NTE.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- NTE.3 - Comment -->
      <xsl:element name="COMMENT">
        <xsl:for-each select="//NTE">
          <xsl:value-of select="./NTE.3"/>
          <xsl:text>&#13;&#10;</xsl:text>
        </xsl:for-each>
      </xsl:element>
      <!-- NTE.4 - Comment Type -->
      <!--  0364 - Comment type :
            1R(Primary Reason), 2R(Secondary Reason), AI(Ancillary Instructions),
            DR(Duplicate/Interaction Reason), GI(General Instructions),
            GR(General Reason), PI(Patient Instructions), RE(Remark) -->
      <xsl:element name="COMMENT_TYPE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//NTE[position()=1]/NTE.4"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - QRD : Original-Style Query Definition      						                  -->
  <!-- ================================================================================== -->
  <xsl:template name="QRD">
    <xsl:element name="QRD">
      <!-- QRD.1 - Query Date/Time -->
      <xsl:element name="QUERY_DTTM">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.2 - Query Format Code -->
      <!--  D(Response is in display format), R(Response is in record-oriented format), T(Response is in tabular format) -->
      <xsl:element name="QUERY_FORMAT_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.3 - Query Priority -->
      <!--  D(Deferred), I(Immediate) -->
      <xsl:element name="QUERY_PRIORITY">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.4 - Query ID -->
      <xsl:element name="QUERY_ID">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.4"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.5 - Deferred Response Type -->
      <!--  B(Before the Date/Time specified), L(Later than the Date/Time specified) -->
      <xsl:element name="DEFERRED_RESPONSE_TYPE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.5"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.6 - Deferred Response Date/Time -->
      <xsl:element name="DEFERRED_RESPONSE_DTTM">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.6"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.7 - Quantity Limited Request -->
      <xsl:element name="QUANTITY_LIMITED_REQUEST">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.7"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.8 - Who Subject Filter -->
      <xsl:element name="WHO_SUBJECT_FILTER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.8"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.9 - What Subject Filter -->
      <!--  ADV(Advice/diagnosis), ANU(Nursing unit lookup (returns patients in beds, excluding empty beds)), APA(Account number query, return matching visit), 
            APM(Medical record number query, returns visits for a medical record number), APN(Patient name lookup), APP(Physician lookup), 
            ARN(Nursing unit lookup (returns patients in beds, including empty beds)), 
            CAN(Cancel.  Used to cancel a query), DEM(Demographics), FIN(Financial), GID(Generate new identifier), GOL(Goals), 
            MRI(Most recent inpatient), MRO(Most recent outpatient), NCK(Network clock), NSC(Network status change), NST(Network statistic), 
            ORD(Order), OTH(Other), PRB(Problems), PRO(Procedure), RAR(Pharmacy administration information), 
            RDR(Pharmacy dispense information), RER(Pharmacy encoded order information), RES(Result), RGR(Pharmacy give information), 
            ROR(Pharmacy prescription information), SAL(All schedule related information, including open slots, booked slots, blocked slots), 
            SBK(Booked slots on the identified schedule), SBL(Blocked slots on the identified schedule), 
            SOF(First open slot on the identified schedule after the start date/tiem), 
            SOP(Open slots on the identified schedule between the begin and end of the start date/time range), 
            SSA(Time slots available for a single appointment), SSR(Time slots available for a recurring appointment), 
            STA(Status), VXI(Vaccine Information), XID(Get cross-referenced identifiers) -->
      <xsl:element name="WHAT_SUBJECT_FILTER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.9"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.10 - What Department Data Code -->
      <xsl:element name="WHAT_DEPARTMENT_DATA_CODE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.10"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.11 - What Data Code Value Qual. -->
      <xsl:element name="WHAT_DATA_CODE_VALUE_QUAL">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.11"/>
        </xsl:call-template>
      </xsl:element>
      <!-- QRD.12 - Query Results Level -->
      <!--  O(Order plus order status), R(Results without bulk text), S(Status only), T(Full results) -->
      <xsl:element name="QUERY_RESULTS_LEVEL">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//QRD/QRD.12"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - QRF : Original style query filter				                                -->
  <!-- ================================================================================== -->
  <xsl:template name="QRF">
    <xsl:element name="QRF">
      <!-- QRF.1 - Where Subject Filter -->
      <xsl:element name="WHERE_SUBJECT_FILTER">
        <xsl:value-of select="//QRF/QRF.1"/>
      </xsl:element>
      <!-- QRF.2 - When Data Start Date/Time -->
      <xsl:element name="WHEN_DATA_START_DTTM">
        <xsl:value-of select="//QRF/QRF.2"/>
      </xsl:element>
      <!-- QRF.3 - When Data End Date/Time -->
      <xsl:element name="WHEN_DATA_END_DTTM">
        <xsl:value-of select="//QRF/QRF.3"/>
      </xsl:element>
      <!-- QRF.4 - What User Qualifier -->
      <xsl:element name="WHAT_USER_QUALIFIER">
        <xsl:value-of select="//QRF/QRF.4"/>
      </xsl:element>
      <!-- QRF.5 - Other QRY Subject Filter -->
      <xsl:element name="OTHER_QRY_SUBJECT_FILTER">
        <xsl:value-of select="//QRF/QRF.5"/>
      </xsl:element>
      <!-- QRF.6 - Which Date/Time Qualifier -->
      <!--  ANY(Any date/time within a range), COL(Collection date/time, equivalent to film or sample collection date/time), 
            ORD(Order date/time), RCT(Specimen receipt date/time, receipt of specimen in filling ancillary (Lab)), 
            REP(Report date/time, report date/time at filing ancillary (i.e., Lab)), SCHED(Schedule date/time) -->
      <xsl:element name="WHICH_DTTM_QUALIFIER">
        <xsl:value-of select="//QRF/QRF.6"/>
      </xsl:element>
      <!-- QRF.7 - Which Date/Time Status Qualifier -->
      <!--  ANY(Any status), CFN(Current final value, whether final or corrected), COR(Corrected only (no final with corrections)), 
            FIN(Final only (no corrections)), PRE(Preliminary), REP(Report completion date/time) -->
      <xsl:element name="WHICH_DTTM_STATUS_QUALIFIER">
        <xsl:value-of select="//QRF/QRF.7"/>
      </xsl:element>
      <!-- QRF.8 - Date/Time Selection Qualifier -->
      <!--  1ST(First value within range), ALL(All values within the range), LST(Last value within the range), 
            REV(All values within the range returned in reverse chronological order (This is the default if not otherwise specified.)) -->
      <xsl:element name="DTTM_SELECTION_QUALIFIER">
        <xsl:value-of select="//QRF/QRF.8"/>
      </xsl:element>
      <!-- QRF.9 - When Quantity/Timing Qualifier -->
      <xsl:element name="WHEN_QUANTITY_TIMING_QUALIFIER">
        <xsl:value-of select="//QRF/QRF.9"/>
      </xsl:element>
      <!-- QRF.10 - Search Confidence Threshold -->
      <xsl:element name="SEARCH_CONFIDENCE_THRESHOLD">
        <xsl:value-of select="//QRF/QRF.10"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- //OBX/OBX.5         																                                -->
  <!-- ================================================================================== -->
  <xsl:template match="//OBX/OBX.5">
    <xsl:value-of select="current()"/>
    <xsl:if test="position() != last()">
      <xsl:text>&#13;&#10;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - AIP : Appointment information						                                -->
  <!-- ================================================================================== -->
  <xsl:template name="AIP">
    <xsl:element name="AIP">
      <!-- AIP.1 - Set ID -->
      <xsl:element name="SET_ID"></xsl:element>
      <!-- AIP.2 - Segment Action Code -->
      <xsl:element name="SEGMENT_ACTION_CODE"></xsl:element>
      <!-- AIP.3 - Personnel Resource ID -->
      <xsl:element name="PERSONNEL_RESOURCE_ID_ID_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AIP/AIP.3/AIP.3.1"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="PERSONNEL_RESOURCE_ID_FAMILY_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AIP/AIP.3/AIP.3.2"/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="PERSONNEL_RESOURCE_ID_GIVEN_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//AIP/AIP.3/AIP.3.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- AIP.4 - Resource Role -->
      <xsl:element name="RESOURCE_ROLE"></xsl:element>
      <!-- AIP.5 - Resource Group -->
      <xsl:element name="RESOURCE_GROUP"></xsl:element>
      <!-- AIP.6 - Start Date/Time -->
      <xsl:element name="START_DATE_TIME"></xsl:element>
      <!-- AIP.7 - Start Date/Time Offset -->
      <xsl:element name="START_DATE_TIME_OFFSET"></xsl:element>
      <!-- AIP.8 - Start Date/Time Offset Units -->
      <xsl:element name="START_DATE_TIME_OFFSET_UNITS"></xsl:element>
      <!-- AIP.9 - Duration -->
      <xsl:element name="DURATION"></xsl:element>
      <!-- AIP.10 - Duration Units -->
      <xsl:element name="DURATION_UNITS"></xsl:element>
      <!-- AIP.11 - Allow Substitution Code -->
      <xsl:element name="ALLOW_SUBSTITUTION_CODE"></xsl:element>
      <!-- AIP.12 - Filler Status Code -->
      <xsl:element name="FILLER_STATUS_CODE"></xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - TXA : Document notification segment			                                -->
  <!-- ================================================================================== -->
  <xsl:template name="TXA">
    <xsl:element name="TXA">
      <!-- TXA.1 - Set ID -->
      <xsl:element name="SET_ID">
      </xsl:element>
      <!-- TXA.2 - Document Type -->
      <!-- 0270 - Document type
            AR(Autopsy report), CD(Cardiodiagnostics), CN(Consultation), DI(Diagnostic imaging), DS(Discharge summary), 
            ED(Emergency department report), HP(History and physical examination), OP(Operative report), PC(Psychiatric consultation), PH(Psychiatric history and physical examination), 
            PN(Procedure note), PR(Progress note), SP(Surgical pathology), TS(Transfer summary)
       -->
      <xsl:element name="DOCUMENT_TYPE">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.2"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.3 - Document Content Presentation -->
      <!-- 0191 - Type of Referenced Data
            AP(Other application data, typically uninterpreted binary data (HL7 V2.3 and later)), 
            AU(Audio data (HL7 V2.3 and later)), 
            FT(Formatted text (HL7 V2.2 only)), 
            IM(Image data (HL7 V2.3 and later)), 
            multipart(MIME multipart package), 
            NS(Non-scanned image (HL7 V2.2 only)), 
            SD(Scanned document (HL7 V2.2 only)), 
            SI(Scanned image (HL7 V2.2 only)), 
            TEXT(Machine readable text document (HL7 V2.3.1 and later)), 
            TX(Machine readable text document (HL7 V2.2 only))
       -->
      <xsl:element name="DOCUMENT_CONTENT_PRESENTATION">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.3"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.4 - Activity Date/Time -->
      <xsl:element name="ACTIVITY_DATE_TIME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.4/TXA.4.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.5 - Primary Activity Provider Code/Name -->
      <xsl:element name="PRIMARY_ACTIVITY_PROVIDER_CODE_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.5"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.6 - Origination Date/Time -->
      <xsl:element name="ORIGINATION_DATE_TIME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.6/TXA.6.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.7 - Transcription Date/Time -->
      <xsl:element name="TRANSCRIPTION_DATE_TIME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.7/TXA.7.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.8 - Edit Date/Time -->
      <xsl:element name="EDIT_DATE_TIME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.8/TXA.8.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.9 - Originator Code/Name -->
      <xsl:element name="ORIGINATOR_CODE_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.9"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.10 - Assigned Document Authenticator -->
      <xsl:element name="ASSIGNED_DOCUMENT_AUTHENTICATOR">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.10"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.11 - Transcriptionist Code/Name -->
      <xsl:element name="TRANSCRIPTIONIST_CODE_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.11"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.12 - Unique Document Number -->
      <xsl:element name="UNIQUE_DOCUMENT_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.12/TXA.12.1"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.13 - Parent Document Number -->
      <xsl:element name="PARENT_DOCUMENT_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.13"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.14 - Placer Order Number -->
      <xsl:element name="PLACER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.14"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.15 - Filler Order Number -->
      <xsl:element name="FILLER_ORDER_NUMBER">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.15"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.16 - Unique Document File Name -->
      <xsl:element name="UNIQUE_DOCUMENT_FILE_NAME">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.16"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.17 - Document Completion Status -->
      <!-- 0271 - Document completion status
            AU(Authenticated), DI(Dictated), DO(Documented), IN(Incomplete),
            IP(In Progress), LA(Legally authenticated), PA(Pre-authenticated)
       -->
      <xsl:element name="DOCUMENT_COMPLETION_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.17"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.18 - Document Confidentiality Status -->
      <!-- 0272 - Document confidentiality status
            R(Restricted), U(Usual control), V(Very restricted) 
       -->
      <xsl:element name="DOCUMENT_CONFIDENTIALITY_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.18"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.19 - Document Availability Status -->
      <!-- 0273 - Document availability status
           AV(Available for patient care), CA(Deleted), OB(Obsolete), UN(Unavailable for patient care)
       -->
      <xsl:element name="DOCUMENT_AVAILABILITY_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.19"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.20 - Document Storage Status -->
      <!-- 0275 - Document storage status
           AA(Active and archived), AC(Active), AR(Archived (not active)), PU(Purged)
       -->
      <xsl:element name="DOCUMENT_STORAGE_STATUS">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.20"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.21 - Document Change Reason -->
      <xsl:element name="DOCUMENT_CHANGE_REASON">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.21"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.22 - Authentication Person, Time Stamp -->
      <xsl:element name="AUTHENTICATION_PERSON_TIME_STAMP">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.22"/>
        </xsl:call-template>
      </xsl:element>
      <!-- TXA.23 - Distributed Copies -->
      <xsl:element name="DISTRIBUTED_COPIES">
        <xsl:call-template name="GetValue">
          <xsl:with-param name="path" select="//TXA/TXA.23"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- GetValue         																                                  -->
  <!--  If there are sub-elements, take the number of the 'count' in the order of the     -->
  <!--  element value with the 'separator'.                                               -->
  <!--  If no sub-elements exists, returns the value of current()                         -->
  <!-- ================================================================================== -->
  <xsl:template name="GetValue">
    <xsl:param name="path"/>
    <xsl:param name="count" select="1"/>
    <xsl:param name="separator"/>
    <xsl:choose>
      <!-- If element have child -->
      <xsl:when test="$path/*">
        <xsl:for-each select="$path/*[position() &lt;= $count]">
          <xsl:value-of select="."/>
          <xsl:if test="position() != last()">
            <xsl:value-of select="$separator"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$path"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- variable - MSPS - !!! DO NOT CHANGED ORDER OF THE ELEMENTS BELOW !!!               -->
  <!-- ================================================================================== -->
  <xsl:variable name="MSPS">
    <xsl:for-each select="//OBR">
      <!-- reqproc_code_value -->
      <xsl:call-template name="GetValue">
        <xsl:with-param name="path" select="./OBR.4"/>
      </xsl:call-template>
      <xsl:value-of select="$FIELD"/>
      <!-- reqproc_code_scheme -->
      <xsl:choose>
        <xsl:when test="string-length(./OBR.4/OBR.4.3) > 0">
          <xsl:value-of select="./OBR.4/OBR.4.3"/>
        </xsl:when>
        <xsl:otherwise>CPT</xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$FIELD"/>
      <!-- sps_id -->
      <xsl:choose>
        <xsl:when test="string-length(./OBR.20) > 0">
          <xsl:call-template name="GetValue">
            <xsl:with-param name="path" select="./OBR.20"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="GetValue">
            <xsl:with-param name="path" select="./OBR.2"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$FIELD"/>
      <!-- modality -->
      <xsl:call-template name="GetValue">
        <xsl:with-param name="path" select="./OBR.24"/>
      </xsl:call-template>
      <xsl:value-of select="$FIELD"/>
      <!-- sps_start_dttm -->
      <xsl:call-template name="GetValue">
        <xsl:with-param name="path" select="./OBR.27/OBR.27.4"/>
      </xsl:call-template>
      <xsl:value-of select="$FIELD"/>
      <!-- protcode_value -->
      <xsl:choose>
        <xsl:when test="string-length(./OBR.4/OBR.4.4) > 0">
          <xsl:value-of select="./OBR.4/OBR.4.4"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./OBR.4/OBR.4.1"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$FIELD"/>
      <!-- protcode_scheme -->
      <xsl:choose>
        <xsl:when test="string-length(./OBR.4/OBR.4.6) > 0">
          <xsl:value-of select="./OBR.4/OBR.4.6"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./OBR.4/OBR.4.3"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$FIELD"/>
      <!-- protcode_meaning -->
      <xsl:choose>
        <xsl:when test="string-length(./OBR.4/OBR.4.5) > 0">
          <xsl:value-of select="./OBR.4/OBR.4.5"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./OBR.4/OBR.4.2"/>
        </xsl:otherwise>
      </xsl:choose>
      <!-- $REPETITION -->
      <xsl:if test="position() != last()">
        <xsl:value-of select="$REPETITION"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

</xsl:stylesheet>