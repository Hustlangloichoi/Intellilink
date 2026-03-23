<?xml version="1.0" encoding="utf-8"?>

<!-- IntelliLink Option(IL_OPTION) Element Example : This will be automatically added to 'DtS_InXml.xml'
Added when processing a received message (e.g., sending an ACK from a TCP Listener) and returning it.

    <IL_OPTION>
      <MessageTypeHl7Config>
        <AcknowledgmentConfig>
          <EnableAcknowledgment>true</EnableAcknowledgment>
          <Code>Automatic</Code>
          <EnableSendingDbErrorMessage>false</EnableSendingDbErrorMessage>
          <EnableNack>false</EnableNack>
        </AcknowledgmentConfig>
        <MshConfig>
          <SendingApplication>IntelliLink</SendingApplication>
          <SendingFacility>INFINITT</SendingFacility>
          <ReceivingApplication>HOSPITAL</ReceivingApplication>
          <ReceivingFacility>HOSPITAL</ReceivingFacility>
          <VersionId>2.3.1</VersionId>
        </MshConfig>
        <IgnoreMessageConfig>
          <EnableIgnoreMessage>false</EnableIgnoreMessage>
          <IgnoreMessageList />
        </IgnoreMessageConfig>
        <InPdfConfig>
          <DeleteTheSourceFileWhenOBX2IsRp>true</DeleteTheSourceFileWhenOBX2IsRp>
          <RequestDicomPdfConfig>
            <EnableRequestDicomPdf>false</EnableRequestDicomPdf>
            <RequestDicomPdf_XsltPath>D:\Dev\DIT\IntelliLink\IntelliLink_VS2022\trunk\IntelliLink\bin\Debug\IntelliLinkLibrary\XSLT\HL7\[HL7][Inbound] Hl7toDicomPdfMetaXml.xslt</RequestDicomPdf_XsltPath>
            <RequestDicomPdf_DirectorySubDirectory>No Sub Directory</RequestDicomPdf_DirectorySubDirectory>
          </RequestDicomPdfConfig>
        </InPdfConfig>
        <G3OutOruConfig>
          <TextType>
            <MultipleObx>
              <EnableSplittingByLineFeedInReportText>true</EnableSplittingByLineFeedInReportText>
              <EnableSplittingLimitingTheCharacterCountOfReportTextPerObx>false</EnableSplittingLimitingTheCharacterCountOfReportTextPerObx>
              <SplittingLimitingTheCharacterCountOfReportTextPerObx>70</SplittingLimitingTheCharacterCountOfReportTextPerObx>
            </MultipleObx>
            <NumberOfObx>Multiple</NumberOfObx>
            <GetAllReportTextsWhenItsAnAddendumReport>false</GetAllReportTextsWhenItsAnAddendumReport>
          </TextType>
          <PdfType>
            <PdfTransferType>Path</PdfTransferType>
          </PdfType>
          <ReportType>Text</ReportType>
        </G3OutOruConfig>
      </MessageTypeHl7Config>
    </IL_OPTION>
-->

<!-- IntelliLink Option(IL_OPTION) Element Example : This will be automatically added to 'DtS_InXml.xml' (Project : G3, General)
Added when setting the resulting message in an outbound context (e.g., sending a message to a TCP Sender).

    <IL_OPTION>
      <ORU>
        <ReportType>Text</ReportType>
        <Text>
          <NumberOfObx>Single</NumberOfObx>
          <EnableSplittingByLineFeedInReportText>true</EnableSplittingByLineFeedInReportText>
          <EnableSplittingLimitingTheCharacterCountOfReportTextPerObx>false</EnableSplittingLimitingTheCharacterCountOfReportTextPerObx>
          <SplittingLimitingTheCharacterCountOfReportTextPerObx>70</SplittingLimitingTheCharacterCountOfReportTextPerObx>
          <GetAllReportTextsWhenItsAnAddendumReport>false</GetAllReportTextsWhenItsAnAddendumReport>
        </Text>
        <PDF>
          <NumberOfObx>Single</NumberOfObx>
          <PdfTransferType>Path</PdfTransferType>
        </PDF>
      </ORU>
      <MshConfig>
        <SendingApplication>IntelliLink</SendingApplication>
        <SendingFacility>INFINITT</SendingFacility>
        <ReceivingApplication>HOSPITAL</ReceivingApplication>
        <ReceivingFacility>HOSPITAL</ReceivingFacility>
        <VersionId>2.3.1</VersionId>
      </MshConfig>
    </IL_OPTION>
-->	

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
  <!-- Report -->
  <xsl:variable name="REPORT_LINEFEED">
    <!-- ~ : G3 Report text line feed -->
    <!--<xsl:value-of select="'~'"/>-->
    <!-- &#10; : enter -->
    <xsl:value-of select="'&#10;'"/>
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
        <xsl:when test="//IL_DB_RESULT">
          <xsl:call-template name="RESPONSE"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="//MESSAGE_TYPE = 'ORM'">
              <xsl:choose>
                <xsl:when test="//OBJECT_TYPE = 'MP'">
                  <xsl:call-template name="ORM_MP"/>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="//MESSAGE_TYPE = 'ORU'">
              <xsl:call-template name="ORU"/>
            </xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- MESSAGE - ORM      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORM_MP">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="ORC"/>
    <xsl:call-template name="OBR"/>
    <xsl:call-template name="OBX_ORM_MP">
      <!-- linkType : 1 = PID, 2 = PID & Accession # -->
      <xsl:with-param name="linkType" select="'1'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - ORU      																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORU">
    <xsl:call-template name="MSH"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="PV1"/>
    <xsl:call-template name="OBR"/>
    <xsl:call-template name="OBX_ORU"/>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- SEGMENT - MSH : Message Header											                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MSH">
    <xsl:element name="MSH">
      <!-- MSH.1 - Field Separator -->
      <xsl:element name="MSH.1">|</xsl:element>
      <!-- MSH.2 - Encoding Characters -->
      <xsl:element name="MSH.2">^~\&amp;</xsl:element>
      <!-- MSH.3 - Sending Application -->
      <xsl:element name="MSH.3">
        <xsl:value-of select="//IL_OPTION/MshConfig/SendingApplication"/>
      </xsl:element>
      <!-- MSH.4 - Sending Facility -->
      <xsl:element name="MSH.4">
        <xsl:value-of select="//IL_OPTION/MshConfig/SendingFacility"/>
      </xsl:element>
      <!-- MSH.5 - Receiving Application -->
      <xsl:element name="MSH.5">
        <xsl:value-of select="//IL_OPTION/MshConfig/ReceivingApplication"/>
      </xsl:element>
      <!-- MSH.6 - Receiving Facility -->
      <xsl:element name="MSH.6">
        <xsl:value-of select="//IL_OPTION/MshConfig/ReceivingFacility"/>
      </xsl:element>
      <!-- MSH.7 - Date/Time Of Message -->
      <xsl:element name="MSH.7">
        <xsl:value-of select="//CURRENT_DTTM"/>
      </xsl:element>
      <!-- MSH.9 - Message Type -->
      <xsl:element name="MSH.9">
        <!-- MSH.9.1 - Message Code -->
        <xsl:element name="MSH.9.1">
          <xsl:value-of select="//MESSAGE_TYPE"/>
        </xsl:element>
        <!-- MSH.9.2 - Trigger Event -->
        <xsl:element name="MSH.9.2">
          <xsl:choose>
            <xsl:when test="//MESSAGE_TYPE = 'ORM'">
              <xsl:choose>
                <xsl:when test="//OBJECT_TYPE = 'MP'">
                  <xsl:text>O01</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//EVENT_TYPE"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
        <!-- MSH.9.3 - Message Structure -->
        <xsl:element name="MSH.9.3">
          <xsl:value-of select="//MESSAGE_STRUCTURE"/>
        </xsl:element>
      </xsl:element>
      <!-- MSH.10 - Message Control ID -->
      <xsl:element name="MSH.10">
        <xsl:value-of select="//CURRENT_DTTM"/>
      </xsl:element>
      <!-- MSH.11 - Processing ID -->
      <xsl:element name="MSH.11">P</xsl:element>
      <!-- MSH.12 - Version ID -->
      <xsl:element name="MSH.12">
        <xsl:value-of select="//IL_OPTION/MshConfig/VersionId"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - PID : Patient Identification							                                -->
  <!-- ================================================================================== -->
  <xsl:template name="PID">
    <xsl:element name="PID">
      <!-- PID.1 - Set ID -->
      <xsl:element name="PID.1"/>
      <!-- PID.2 - Patient ID -->
      <xsl:element name="PID.2"/>
      <!-- PID.3 - Patient Identifier List -->
      <xsl:element name="PID.3">
        <xsl:value-of select="//PATIENT_ID"/>
      </xsl:element>
      <!-- PID.5 - Patient Name -->
      <xsl:element name="PID.5">
        <xsl:value-of select="//PATIENT_NAME"/>
      </xsl:element>
      <!-- PID.7 - Date/Time of Birth -->
      <xsl:element name="PID.7">
        <xsl:value-of select="//PATIENT_BIRTH_DTTM"/>
      </xsl:element>
      <!-- PID.8 - Administrative Sex -->
      <!-- 0001 - Administrative Sex :
            A(Ambiguous), F(Female), M(Male), N(Not applicable), O(Other), U(Unknown) -->
      <xsl:element name="PID.8">
        <xsl:value-of select="//PATIENT_SEX"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - PV1 : Patient Visit											                                -->
  <!-- ================================================================================== -->
  <xsl:template name="PV1">
    <xsl:element name="PV1">
      <!-- PV1.1 - Set ID -->
      <xsl:element name="PV1.1"/>
      <!-- PV1.2 - Patient Class -->
      <!-- 0004 - Patient Class :
            B(Obstetrics), C(Commercial Account), E(Emergency), I(Inpatient), N(Not Applicable),
            O(Outpatient), P(Preadmit), R(Recurring patient), U(Unknown) -->
      <xsl:element name="PV1.2">
        <xsl:choose>
          <xsl:when test="string-length(//PATIENT_LOCATION) > 0">
            <xsl:value-of select="//PATIENT_LOCATION"/>
          </xsl:when>
          <xsl:otherwise>E</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
        <!-- PV1.3 - Assigned Patient Location -->
      <xsl:element name="PV1.3">
        <xsl:value-of select="//PATIENT_RESIDENCY"/>
      </xsl:element>
      <!-- PV1.4 - Admission Type -->
      <xsl:element name="PV1.4"/>
      <!-- PV1.5 - Preadmit Number -->
      <xsl:element name="PV1.5"/>
      <!-- PV1.7 - Attending Doctor -->
      <xsl:element name="PV1.7">
        <xsl:element name="PV1.7.1">
          <xsl:value-of select="//ATTEND_DOCTOR_ID"/>
        </xsl:element>
        <xsl:element name="PV1.7.2">
          <xsl:value-of select="//ATTEND_DOCTOR_LAST_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.7.3">
          <xsl:value-of select="//ATTEND_DOCTOR_FIRST_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.7.4">
          <xsl:value-of select="//ATTEND_DOCTOR_MIDDLE_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.7.5">
          <xsl:value-of select="//ATTEND_DOCTOR_SUFFIX"/>
        </xsl:element>
        <xsl:element name="PV1.7.6">
          <xsl:value-of select="//ATTEND_DOCTOR_PREFIX"/>
        </xsl:element>
      </xsl:element>
      <!-- PV1.8 - Referring Doctor -->
      <xsl:element name="PV1.8">
        <xsl:element name="PV1.8.1">
          <xsl:value-of select="//REFER_DOCTOR_ID"/>
        </xsl:element>
        <xsl:element name="PV1.8.2">
          <xsl:value-of select="//REFER_DOCTOR_LAST_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.8.3">
          <xsl:value-of select="//REFER_DOCTOR_FIRST_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.8.4">
          <xsl:value-of select="//REFER_DOCTOR_MIDDLE_NAME"/>
        </xsl:element>
        <xsl:element name="PV1.8.5">
          <xsl:value-of select="//REFER_DOCTOR_SUFFIX"/>
        </xsl:element>
        <xsl:element name="PV1.8.6">
          <xsl:value-of select="//REFER_DOCTOR_PREFIX"/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - ORC : Common Order					  						                                -->
  <!-- ================================================================================== -->
  <xsl:template name="ORC">
    <xsl:element name="ORC">
      <!-- ORC.1 - Order Control -->
      <!-- 0119 - Order control codes :
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
      <xsl:element name="ORC.1">
        <xsl:value-of select="//EVENT_TYPE"/>
      </xsl:element>
      <!-- ORC.2 - Placer Order Number -->
      <xsl:element name="ORC.2">
        <xsl:choose>
          <xsl:when test="string-length(//PLACER_ORDER_ID) > 0">
            <xsl:value-of select="//PLACER_ORDER_ID"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//FILLER_ORDER_ID"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- ORC.3 - Filler Order Number -->
      <xsl:element name="ORC.3">
        <xsl:value-of select="//FILLER_ORDER_ID"/>
      </xsl:element>
      <!-- ORC.5 - Order Status -->
      <!-- 0038 - Order status :
            A(Some, but not all, results available), CA(Order was canceled), CM(Order is completed), DC(Order was discontinued), ER(Error, order not found),
            HD(Order is on hold), IP(In process, unspecified), RP(Order has been replaced), SC(In process, scheduled) -->
      <xsl:element name="ORC.5">
        <xsl:value-of select="//OBJECT_TYPE"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - OBR : Observation Request 																                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBR">
    <xsl:element name="OBR">
      <!-- OBR.1 - Set ID -->
      <xsl:element name="OBR.1">1</xsl:element>
      <!-- OBR.2 - Placer Order Number -->
      <xsl:element name="OBR.2">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBR.3 - Filler Order Number -->
      <xsl:element name="OBR.3">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBR.4 - Universal Service Identifier -->
      <xsl:element name="OBR.4">
        <xsl:element name="OBR.4.1">
          <xsl:value-of select="//REQUEST_CODE"/>
        </xsl:element>
        <xsl:element name="OBR.4.2">
          <xsl:value-of select="//REQUEST_NAME"/>
        </xsl:element>
      </xsl:element>
      <!-- OBR.6 - Requested Date/Time -->
      <xsl:element name="OBR.6">
        <xsl:value-of select="//STUDY_DTTM"/>
      </xsl:element>
      <!-- OBR.7 - Observation Date/Time -->
      <xsl:element name="OBR.7">
        <xsl:value-of select="//APPROVAL_DTTM"/>
      </xsl:element>
      <!-- OBR.18 - Placer Field 1 -->
      <xsl:element name="OBR.18">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBR.19 - Placer Field 2 -->
      <xsl:element name="OBR.19">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBR.24 - Diagnostic Serv Sect ID -->
      <!-- 0074 - Diagnostic Service Section ID :
            AU(Audiology), BG(Blood Gases), BLB(Blood Bank), CH(Chemistry), CP(Cytopathology),
            CT(CAT Scan), CTH(Cardiac Catheterization), CUS(Cardiac Ultrasound), EC(Electrocardiac (e.g., EKG,  EEC, Holter)), EN(Electroneuro (EEG, EMG,EP,PSG)),
            HM(Hematology), ICU(Bedside ICU Monitoring), IMM(Immunology), LAB(Laboratory), MB(Microbiology),
            MCB(Mycobacteriology), MYC(Mycology), NMR(Nuclear Magnetic Resonance), NMS(Nuclear Medicine Scan), NRS(Nursing Service Measures),
            OSL(Outside Lab), OT(Occupational Therapy), OTH(Other), OUS(OB Ultrasound), PF(Pulmonary Function),
            PHR(Pharmacy), PHY(Physician (Hx. Dx, admission note, etc.)), PT(Physical Therapy), RAD(Radiology), RC(Respiratory Care (therapy)),
            RT(Radiation Therapy), RUS(Radiology Ultrasound), RX(Radiograph), SP(Surgical Pathology), SR(Serology),
            TX(Toxicology), VR(Virology), VUS(Vascular Ultrasound), XRC(Cineradiograph) -->
      <xsl:element name="OBR.24">
        <xsl:value-of select="//PERFORM_MODALITY"/>
      </xsl:element>
      <!-- OBR.25 - Result Status -->
      <xsl:element name="OBR.25">
        <xsl:choose>
          <xsl:when test="//OBJECT_TYPE = 'R'">
            <xsl:call-template name="GET_STUDY_STAT">
              <xsl:with-param name="stat" select="//STUDY_STAT"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="//OBJECT_TYPE = 'A'">
            <xsl:call-template name="GET_STUDY_STAT">
              <xsl:with-param name="stat" select="//STUDY_ADDENDUM_STAT"/>
            </xsl:call-template>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
      <!-- OBR.36 - Scheduled Date/Time -->
      <xsl:element name="OBR.36">
        <xsl:value-of select="//STUDY_DTTM"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="GET_STUDY_STAT">
    <xsl:param name="stat"/>
    <xsl:choose>
      <xsl:when test="$stat = '240'">F</xsl:when>
      <xsl:when test="$stat = '340'">A</xsl:when>
      <xsl:otherwise>P</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- OBX_ORU         																                                  -->
  <!-- ================================================================================== -->
  <xsl:template name="OBX_ORU">
    <xsl:variable name="numberOfObx">
      <xsl:choose>
        <xsl:when test="//IL_OPTION/ORU/ReportType = 'Text'">
          <xsl:value-of select="//IL_OPTION/ORU/Text/NumberOfObx"/>
        </xsl:when>
        <xsl:when test="//IL_OPTION/ORU/ReportType = 'PDF'">Single</xsl:when>
        <xsl:otherwise>Multiple</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="reportText">
      <xsl:choose>
        <xsl:when test="//OBJECT_TYPE = 'R' and //IL_OPTION/ORU/Text/GetAllReportTextsWhenItsAnAddendumReport = 'true'">
          <xsl:value-of select="//ALL_REPORT_TEXT"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="//REPORT_TEXT"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <!-- OBX - Single -->
      <xsl:when test="$numberOfObx = 'Single'">
        <xsl:call-template name="OBX_REPORT_TEXT_SINGLE_LINE">          
          <xsl:with-param name="reportText" select="$reportText"/>
          <xsl:with-param name="seqNo" select="1"/>
        </xsl:call-template>
      </xsl:when>
      <!-- OBX - Multiple -->
      <xsl:when test="$numberOfObx = 'Multiple'">
        <xsl:variable name="enableSplittingByLineFeedInReportText" select="//IL_OPTION/ORU/Text/EnableSplittingByLineFeedInReportText"/>
        <xsl:variable name="enableSplittingLimitingTheCharacterCountOfReportTextPerObx" select="//IL_OPTION/ORU/Text/EnableSplittingLimitingTheCharacterCountOfReportTextPerObx"/>
        <xsl:choose>
          <xsl:when test="$enableSplittingByLineFeedInReportText = 'true'">
            <xsl:choose>
              <xsl:when test="$enableSplittingLimitingTheCharacterCountOfReportTextPerObx = 'false'">
                <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED">
                  <xsl:with-param name="string" select="$reportText"/>
                  <xsl:with-param name="delimiter" select="$REPORT_LINEFEED"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="$enableSplittingLimitingTheCharacterCountOfReportTextPerObx = 'true'">
                <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER">
                  <xsl:with-param name="string" select="$reportText"/>
                  <xsl:with-param name="delimiter" select="$REPORT_LINEFEED"/>
                  <xsl:with-param name="limitingCount" select="number(//IL_OPTION/ORU/Text/SplittingLimitingTheCharacterCountOfReportTextPerObx)"/>
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- OBX_REPORT_TEXT_SINGLE_LINE												                                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBX_REPORT_TEXT_SINGLE_LINE">
    <xsl:param name="seqNo"/>
    <xsl:param name="reportText"/>
    <xsl:element name="OBX">
      <!-- OBX.1 - Set ID -->
      <xsl:element name="OBX.1">
        <xsl:value-of select="$seqNo"/>
      </xsl:element>
      <!-- OBX.2 - Value Type -->
      <!--  TX(Text Data (Display)), ED(Encapsulated Data), RP(Reference Pointer), FT(Formatted Text (Display))-->
      <xsl:element name="OBX.2">
        <xsl:choose>
          <xsl:when test="//IL_OPTION/ORU/ReportType = 'PDF'">
            <xsl:choose>
              <xsl:when test="//IL_OPTION/ORU/PDF/PdfTransferType = 'Path'">RP</xsl:when>
              <xsl:when test="//IL_OPTION/ORU/PDF/PdfTransferType = 'Content'">ED</xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>TX</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.3 - Observation Identifier -->
      <xsl:element name="OBX.3">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBX.4 - Observation Sub-ID -->
      <xsl:element name="OBX.4">
        <xsl:value-of select="//STUDY_INSTANCE_UID"/>
      </xsl:element>
      <!-- OBX.5 - Observation Value -->
      <xsl:choose>
        <xsl:when test="//IL_OPTION/ORU/ReportType = 'Text'">
          <xsl:call-template name="ADD_ELEMENT_BY_STRING_SPLIT">
            <xsl:with-param name="elementName" select="'OBX.5'" />
            <xsl:with-param name="string" select="$reportText" />
            <xsl:with-param name="delimiter" select="$REPORT_LINEFEED" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="//IL_OPTION/ORU/ReportType = 'PDF'">
          <xsl:choose>
            <xsl:when test="//IL_OPTION/ORU/PDF/PdfTransferType = 'Path'">
              <xsl:element name="OBX.5">
                <xsl:element name="OBX.5.1">
                  <xsl:value-of select="//PDF_FILE_PATH"/>
                </xsl:element>
              </xsl:element>
            </xsl:when>
            <xsl:when test="//IL_OPTION/ORU/PDF/PdfTransferType = 'Content'">
              <xsl:element name="OBX.5">
                <xsl:element name="OBX.5.1">IntelliLink</xsl:element>
                <xsl:element name="OBX.5.2">Image</xsl:element>
                <xsl:element name="OBX.5.3">PDF</xsl:element>
                <xsl:element name="OBX.5.4">Base64</xsl:element>
                <xsl:element name="OBX.5.5">
                  <xsl:value-of select="cs:Convert_ToBase64String(//PDF_FILE_PATH, 'utf-8')"/>
                </xsl:element>
              </xsl:element>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
      <!-- OBX.11 - Observation Result Status -->
      <xsl:element name="OBX.11">
        <xsl:choose>
          <xsl:when test="//STUDY_STAT = '240'">F</xsl:when>
          <xsl:when test="//STUDY_STAT = '340'">A</xsl:when>
          <xsl:otherwise>P</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.14 - Date/Time of the Observation -->
      <xsl:element name="OBX.14">
        <xsl:value-of select="//APPROVAL_DTTM"/>
      </xsl:element>
      <!-- OBX.16 - Responsible Observer -->
      <xsl:element name="OBX.16">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED														                    -->
  <!-- ================================================================================== -->
  <xsl:template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED">
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:param name="index" select="0" />
    <xsl:choose>
      <xsl:when test="contains($string, $delimiter)">
        <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
          <xsl:with-param name="reportText" select="substring-before($string, $delimiter)"/>
          <xsl:with-param name="seqNo" select="$index + 1"/>
        </xsl:call-template>
        <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED"> <!-- Recursive Call -->
          <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
          <xsl:with-param name="index" select="$index + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
          <xsl:with-param name="reportText" select="$string"/>
          <xsl:with-param name="seqNo" select="$index + 1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER			                    -->
  <!-- ================================================================================== -->
  <xsl:template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER">
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:param name="limitingCount"/>
    <xsl:param name="index" select="0" />        
    <xsl:choose>
      <xsl:when test="contains($string, $delimiter)">
        <xsl:variable name="delimiterBefore" select="substring-before($string, $delimiter)"/>
        <xsl:variable name="delimiterAfter" select="substring-after($string, $delimiter)"/>
        <xsl:choose>
          <xsl:when test="$limitingCount >= string-length($delimiterBefore)">
            <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
              <xsl:with-param name="reportText" select="$delimiterBefore"/>
              <xsl:with-param name="seqNo" select="$index + 1"/>              
            </xsl:call-template>
            <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER">
              <xsl:with-param name="string" select="$delimiterAfter"/>
              <xsl:with-param name="delimiter" select="$delimiter"/>
              <xsl:with-param name="limitingCount" select="$limitingCount"/>
              <xsl:with-param name="index" select="$index + 1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
              <xsl:with-param name="reportText" select="substring($delimiterBefore, 1, $limitingCount)"/>
              <xsl:with-param name="seqNo" select="$index + 1"/>
            </xsl:call-template>
            <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER">
              <xsl:with-param name="string" select="concat(substring($delimiterBefore, $limitingCount + 1), $delimiter, $delimiterAfter)"/>
              <xsl:with-param name="delimiter" select="$delimiter"/>
              <xsl:with-param name="limitingCount" select="$limitingCount"/>
              <xsl:with-param name="index" select="$index + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="string-length($string) > $limitingCount">
            <xsl:variable name="countSplitBefore" select="substring($string, 1, $limitingCount)"/>
            <xsl:variable name="countSplitAfter" select="substring($string, $limitingCount + 1)"/>
            <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
              <xsl:with-param name="reportText" select="$countSplitBefore"/>
              <xsl:with-param name="seqNo" select="$index + 1"/>
            </xsl:call-template>
            <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LINE_FEED_AND_LIMITING_CHARACTER">
              <xsl:with-param name="string" select="$countSplitAfter"/>
              <xsl:with-param name="delimiter" select="$delimiter"/>
              <xsl:with-param name="index" select="$index + 1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
              <xsl:with-param name="reportText" select="$string"/>
              <xsl:with-param name="seqNo" select="$index + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MAKE_OBX_MULTIPLE_LINE_BY_LIMITING_CHARACTER             			                    -->
  <!-- ================================================================================== -->
  <xsl:template name="MAKE_OBX_MULTIPLE_LINE_BY_LIMITING_CHARACTER">
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:param name="index" select="0" />
    <xsl:variable name="limitingCount" select="number(//LimitingTheCharacterCountOfReportTextPerObx)"/>
    <xsl:choose>
      <xsl:when test="string-length($string) > $limitingCount">
        <xsl:variable name="countSplitBefore" select="substring($string, 1, $limitingCount)"/>
        <xsl:variable name="countSplitAfter" select="substring($string, $limitingCount + 1)"/>
        <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
          <xsl:with-param name="reportText" select="$countSplitBefore"/>
          <xsl:with-param name="seqNo" select="$index + 1"/>
        </xsl:call-template>
        <xsl:call-template name="MAKE_OBX_MULTIPLE_LINE_BY_LIMITING_CHARACTER">
          <xsl:with-param name="string" select="$countSplitAfter"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
          <xsl:with-param name="index" select="$index + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
          <xsl:with-param name="reportText" select="$string"/>
          <xsl:with-param name="seqNo" select="$index + 1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- OBX_REPORT_TEXT_MULTIPLE_LINE											                                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBX_REPORT_TEXT_MULTIPLE_LINE">
    <xsl:param name="seqNo"/>
    <xsl:param name="reportText"/>
    <xsl:element name="OBX">
      <!-- OBX.1 - Set ID -->
      <xsl:element name="OBX.1">
        <xsl:value-of select="$seqNo"/>
      </xsl:element>
      <!-- OBX.2 - Value Type : TX = Text Data (Display)-->
      <xsl:element name="OBX.2">TX</xsl:element>
      <!-- OBX.3 - Observation Identifier -->
      <xsl:element name="OBX.3">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- OBX.4 - Observation Sub-ID -->
      <xsl:element name="OBX.4">
        <xsl:value-of select="//STUDY_INSTANCE_UID"/>
      </xsl:element>
      <!-- OBX.5 - Observation Value -->
      <xsl:element name="OBX.5">
        <xsl:value-of select="$reportText"/>
      </xsl:element>
      <!-- OBX.11 - Observation Result Status -->
      <xsl:element name="OBX.11">
        <xsl:choose>
          <xsl:when test="//STUDY_STAT = '240'">F</xsl:when>
          <xsl:when test="//STUDY_STAT = '340'">A</xsl:when>
          <xsl:otherwise>P</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.14 - Date/Time of the Observation -->
      <xsl:element name="OBX.14">
        <xsl:value-of select="//APPROVAL_DTTM"/>
      </xsl:element>
      <!-- OBX.16 - Responsible Observer -->
      <xsl:element name="OBX.16">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- OBX_ORM_MP         																                                -->
  <!-- ================================================================================== -->
  <xsl:template name="OBX_ORM_MP">
    <xsl:param name="linkType"/>
    <xsl:element name="OBX">
      <!-- OBX.1 -Set ID -->
      <xsl:element name="OBX.1">1</xsl:element>
      <!-- OBX.2 - Value Type -->
      <xsl:element name="OBX.2">RP</xsl:element> <!-- RP : Reference Pointer -->
      <!-- OBX.3 - Observation Identifier -->
      <xsl:element name="OBX.3">
        <xsl:choose>
          <xsl:when test="linkType = '1'">
            <xsl:element name="OBX.5">?MX=1&amp;LID=medi&amp;LPW=medi&amp;PID=<xsl:value-of select="//ACCESS_NO"/></xsl:element>
          </xsl:when>
          <xsl:when test="linkType = '2'">
            <xsl:element name="OBX.5">?MX=1&amp;LID=medi&amp;LPW=medi&amp;PID=<xsl:value-of select="//PATIENT_ID"/>&amp;AN=<xsl:value-of select="//ACCESS_NO"/></xsl:element>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:element>
      <!-- OBX.11 - Observation Result Status -->
      <xsl:element name="OBX.11">
        <xsl:choose>
          <xsl:when test="//STUDY_STAT = '240'">F</xsl:when>
          <xsl:when test="//STUDY_STAT = '340'">A</xsl:when>
          <xsl:otherwise>P</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - QRD : Original-Style Query Definition		                                -->
  <!-- ================================================================================== -->
  <xsl:template name="QRD">
    <xsl:element name="QRD">
      <!-- QRD.1 - Query Date/Time -->
      <xsl:element name="QRD.1">
        <xsl:value-of select="//CURRENT_DTTM"/>
      </xsl:element>
      <!-- QRD.2 - Query Format Code -->
      <!--  D(Response is in display format), R(Response is in record-oriented format), T(Response is in tabular format) -->
      <xsl:element name="QRD.2">
        <xsl:value-of select="//QRD/QUERY_FORMAT_CODE"/>
      </xsl:element>
      <!-- QRD.3 - Query Priority -->
      <!--  D(Deferred), I(Immediate) -->
      <xsl:element name="QRD.3">
        <xsl:value-of select="//QRD/QUERY_PRIORITY"/>
      </xsl:element>
      <!-- QRD.4 - Query ID -->
      <xsl:element name="QRD.4">
        <xsl:value-of select="//QRD/QUERY_ID"/>
      </xsl:element>
      <!-- QRD.7 - Quantity Limited Request -->
      <xsl:element name="QRD.7">
        <!-- Quantity -->
        <xsl:element name="QRD.7.1">1</xsl:element>
        <!-- Units -->
        <!--  CH(Characters), LI(lines) PG(Pages), RD(Records), ZO(Locally defined) -->
        <xsl:element name="QRD.7.2">RD</xsl:element>
      </xsl:element>
      <!-- QRD.8 - Who Subject Filter -->
      <xsl:element name="QRD.8">
        <xsl:value-of select="//ACCESS_NO"/>
      </xsl:element>
      <!-- QRD.9 - What Subject Filter -->
      <xsl:element name="QRD.9"/>
      <!-- QRD.10 - What Department Data Code -->
      <xsl:element name="QRD.10"/>
    </xsl:element>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- SEGMENT - QAK : Query Acknowledgment           		                                -->
  <!-- ================================================================================== -->
  <xsl:template name="QAK">
    <xsl:element name="QAK">
      <!-- QAK.1 - Query Tag -->
      <xsl:element name="QAK.1">
        <xsl:value-of select="//MSH/MESSAGE_CONTROL_ID"/>
      </xsl:element>
      <!-- QAK.2 - Query Response Status -->
      <!--  AE(Application error), AR(Application reject), NF(No data found, no errors), OK(Data found, no errors (this is the default)) -->
      <xsl:element name="QAK.2">
      </xsl:element>
      <!-- QAK.3 - Message Query Name -->
      <xsl:element name="QAK.3">
      </xsl:element>
      <!-- QAK.4 - Hit Count Total -->
      <xsl:element name="QAK.4">
      </xsl:element>
      <!-- QAK.5 - This payload -->
      <xsl:element name="QAK.5">
      </xsl:element>
      <!-- QAK.6 - Hits remaining -->
      <xsl:element name="QAK.6">
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- SEGMENT - QPD : Query Parameter Definition      		                                -->
  <!-- ================================================================================== -->
  <xsl:template name="QPD">
    <xsl:element name="QPD">
      <!-- QPD.1 - Message Query Name -->
      <xsl:element name="QPD.1">
      </xsl:element>
      <!-- QPD.2 - Query Tag -->
      <xsl:element name="QPD.2">
      </xsl:element>
      <!-- QPD.3 - User Parameters -->
      <xsl:element name="QPD.3">
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- ADD_ELEMENT_BY_STRING_SPLIT                                                        -->
  <!--  Separate the string by delimiter to create an element with the input element name -->
  <!-- ================================================================================== -->
  <xsl:template name="ADD_ELEMENT_BY_STRING_SPLIT">
    <xsl:param name="elementName"/>
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:variable name="afterString" select="substring-after($string, substring-before($string, substring-before($string, ' ')))"/>
    <xsl:choose>
      <xsl:when test="contains($afterString, $delimiter)">
      <xsl:element name ="{$elementName}">
          <xsl:value-of select="cs:String_TrimEnd(substring-before($afterString, $delimiter))"/>
      </xsl:element>
        <xsl:call-template name="ADD_ELEMENT_BY_STRING_SPLIT">
          <xsl:with-param name="elementName" select="$elementName"/>
          <xsl:with-param name="string" select="substring-after($afterString, $delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name ="{$elementName}">
          <xsl:value-of select="cs:String_TrimEnd($afterString)"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- RESPONSE  																                                          -->
  <!-- ================================================================================== -->
  <xsl:template name="RESPONSE">
    <xsl:choose>
      <xsl:when test="//MSH/MESSAGE_CODE = 'QRY'">
        <xsl:call-template name="ORF"/>
      </xsl:when>
      <xsl:when test="//MSH/MESSAGE_CODE = 'QBP'">
        <xsl:call-template name="RSP"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="RESPONSE_ACK"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ================================================================================== -->
  <!-- MESSAGE - RSP : Response to Query by Parameter                                   -->
  <!-- ================================================================================== -->
  <xsl:template name="RSP">
    <xsl:call-template name="RESPONSE_MSH">
      <xsl:with-param name="messageCode" select="'RSP'"/>
      <xsl:with-param name="triggerEvent" select="'K23'"/>
      <xsl:with-param name="messageStructure" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="RESPONSE_MSA"/>
    <xsl:call-template name="QAK"/>
    <xsl:call-template name="QPD"/>
    <xsl:call-template name="PID"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - ORF : Query for results of observation                                   -->
  <!-- ================================================================================== -->
  <xsl:template name="ORF">
    <xsl:call-template name="RESPONSE_MSH">
      <xsl:with-param name="messageCode" select="'ORF'"/>
      <xsl:with-param name="triggerEvent" select="'R04'"/>
      <xsl:with-param name="messageStructure" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="RESPONSE_MSA"/>
    <xsl:call-template name="QRD"/>
    <xsl:call-template name="PID"/>
    <xsl:call-template name="OBR"/>
    <xsl:call-template name="OBX_ORU"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- MESSAGE - RESPONSE_ACK															                                -->
  <!-- ================================================================================== -->
  <xsl:template name="RESPONSE_ACK">
    <xsl:variable name="messageCode">
      <xsl:choose>
        <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/EnableNack = 'true' and //IL_DB_RESULT = 'false'">NACK</xsl:when>
        <xsl:otherwise>ACK</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="RESPONSE_MSH">
      <xsl:with-param name="messageCode" select="$messageCode"/>
      <xsl:with-param name="triggerEvent" select="''"/>
      <xsl:with-param name="messageStructure" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="RESPONSE_MSA"/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - RESPONSE_MSH : Message Header	 					                                -->
  <!-- ================================================================================== -->
  <xsl:template name="RESPONSE_MSH">
    <xsl:param name="messageCode"/>
    <xsl:param name="triggerEvent"/>
    <xsl:param name="messageStructure"/>

    <xsl:element name="MSH">
      <!-- MSH.1 - Field Separator -->
      <xsl:element name="MSH.1">|</xsl:element>
      <!-- MSH.2 - Encoding Characters -->
      <xsl:element name="MSH.2">^~\&amp;</xsl:element>
      <!-- MSH.3 - Sending Application -->
      <xsl:element name="MSH.3">
        <xsl:value-of select="//IL_OPTION/MessageTypeHl7Config/MshConfig/SendingApplication"/>
      </xsl:element>
      <!-- MSH.4 - Sending Facility -->
      <xsl:element name="MSH.4">
        <xsl:value-of select="//IL_OPTION/MessageTypeHl7Config/MshConfig/SendingFacility"/>
      </xsl:element>
      <!-- MSH.5 - Receiving Application -->
      <xsl:element name="MSH.5">
        <xsl:value-of select="//IL_OPTION/MessageTypeHl7Config/MshConfig/ReceivingApplication"/>
      </xsl:element>
      <!-- MSH.6 - Receiving Facility -->
      <xsl:element name="MSH.6">
        <xsl:value-of select="//IL_OPTION/MessageTypeHl7Config/MshConfig/ReceivingFacility"/>
      </xsl:element>
      <!-- MSH.7 - Date/Time Of Message -->
      <xsl:element name="MSH.7">
        <xsl:value-of select="cs:DateTime_Now('yyyyMMddHHmmss')"/>
      </xsl:element>
      <!-- MSH.9 - Message Type -->
      <xsl:element name="MSH.9">
        <!-- MSH.9.1 - Message Code -->
        <xsl:element name="MSH.9.1">
          <xsl:value-of select="$messageCode"/>
        </xsl:element>
        <!-- MSH.9.2 - Trigger Event -->
        <xsl:element name="MSH.9.2">
          <xsl:value-of select="$triggerEvent"/>
        </xsl:element>
        <!-- MSH.9.3 - Message Structure -->
        <xsl:element name="MSH.9.3">
          <xsl:value-of select="$messageStructure"/>
        </xsl:element>
      </xsl:element>
      <!-- MSH.10 - Message Control ID -->
      <xsl:element name="MSH.10">
        <xsl:value-of select="cs:DateTime_Now('yyyyMMddHHmmss')"/>
      </xsl:element>
      <!-- MSH.11 - Processing ID -->
      <xsl:element name="MSH.11">P</xsl:element>
      <!-- MSH.12 - Version ID -->
      <xsl:element name="MSH.12">
        <xsl:value-of select="//IL_OPTION/MessageTypeHl7Config/MshConfig/VersionId"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - RESPONSE_MSA : Message Acknowledgment		                                -->
  <!-- ================================================================================== -->
  <xsl:template name="RESPONSE_MSA">
    <xsl:variable name="V_ACK_CODE">
      <xsl:choose>
        <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'Automatic'">
          <xsl:choose>
            <xsl:when test="string-length(//MSH/ACCEPT_ACKNOWLEDGMENT_TYPE) > 0 or string-length(//MSH/APPLICATION_ACKNOWLEDGMENT_TYPE) > 0">
              <!-- Enhanced -->
              <xsl:choose>
                <xsl:when test="//IL_DB_RESULT = 'true'">CA</xsl:when>
                <xsl:otherwise>CR</xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <!-- Original -->
              <xsl:choose>
                <xsl:when test="//IL_DB_RESULT = 'true'">AA</xsl:when>
                <xsl:otherwise>AR</xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'Automatic - Original'">
          <xsl:choose>
            <xsl:when test="//IL_DB_RESULT = 'true'">AA</xsl:when>
            <xsl:otherwise>AR</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'Automatic - Enhanced'">
          <xsl:choose>
            <xsl:when test="//IL_DB_RESULT = 'true'">CA</xsl:when>
            <xsl:otherwise>CR</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'AA'">AA</xsl:when>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'AE'">AE</xsl:when>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'AR'">AR</xsl:when>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'CA'">CA</xsl:when>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'CE'">CE</xsl:when>
            <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/Code = 'CR'">CR</xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name="MSA">
      <!-- MSA.1 - Acknowledgment Code -->
      <xsl:element name="MSA.1">
        <xsl:value-of select="$V_ACK_CODE"/>
      </xsl:element>
      <!-- MSA.2 - Message Control Id -->
      <xsl:element name="MSA.2">
        <xsl:value-of select="//MSH/MESSAGE_CONTROL_ID"/>
      </xsl:element>
      <!-- MSA.3 - Text Message -->
      <xsl:element name="MSA.3">
        <xsl:choose>
          <xsl:when test="$V_ACK_CODE = 'AA'">Message processed</xsl:when>
          <xsl:when test="$V_ACK_CODE = 'AE'">
            <xsl:choose>
              <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/EnableSendingDbErrorMessage = 'true'">
                <xsl:value-of select="//IL_DB_ERROR_TEXT"/>
              </xsl:when>
              <xsl:otherwise>Application Error</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$V_ACK_CODE = 'AR'">
            <xsl:choose>
              <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/EnableSendingDbErrorMessage = 'true'">
                <xsl:value-of select="//IL_DB_ERROR_TEXT"/>
              </xsl:when>
              <xsl:otherwise>Application Reject</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$V_ACK_CODE = 'CA'">Commit Accept</xsl:when>
          <xsl:when test="$V_ACK_CODE = 'CE'">
            <xsl:choose>
              <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/EnableSendingDbErrorMessage = 'true'">
                <xsl:value-of select="//IL_DB_ERROR_TEXT"/>
              </xsl:when>
              <xsl:otherwise>Commit Error</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$V_ACK_CODE = 'CR'">
            <xsl:choose>
              <xsl:when test="//IL_OPTION/MessageTypeHl7Config/AcknowledgmentConfig/EnableSendingDbErrorMessage = 'true'">
                <xsl:value-of select="//IL_DB_ERROR_TEXT"/>
              </xsl:when>
              <xsl:otherwise>Commit Reject</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ================================================================================== -->
  <!-- SEGMENT - MSA : Message Acknowledgment							                                -->
  <!-- ================================================================================== -->
  <xsl:template name="MSA">
    <xsl:element name="MSA">
      <!-- MSA.1 - Acknowledgment Code -->
      <xsl:element name="MSA.1">AA</xsl:element>
      <!-- MSA.2 - Message Control Id -->
      <xsl:element name="MSA.2">
        <xsl:value-of select="//MSH/MESSAGE_CONTROL_ID"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
