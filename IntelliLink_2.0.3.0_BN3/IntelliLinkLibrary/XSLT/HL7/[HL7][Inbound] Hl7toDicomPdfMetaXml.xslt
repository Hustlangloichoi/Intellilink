<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:hl7="urn:hl7-org:v3"
                xmlns:cs="urn:xslt-helpers">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

  <!-- ================================================================================== -->
  <!--	Remove invalid text																                                -->
  <!-- ================================================================================== -->
  <xsl:template match="text()"/>

  <!-- ================================================================================== -->
  <!--	Root																			                                        -->
  <!-- ================================================================================== -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- ================================================================================== -->
  <!--	Body            												  							                          -->
  <!-- ================================================================================== -->
  <xsl:template match="*">
      <xsl:element name="DicomCreator">
        <xsl:element name="Study">
          <xsl:element name="PatientName">
            <xsl:value-of select="//PID/PID.5/PID.5.1"/>^<xsl:value-of select="//PID/PID.5/PID.5.2"/>
          </xsl:element>
          <xsl:element name="PatientID">
            <xsl:value-of select="//PID/PID.3/PID.3.1"/>
          </xsl:element>
          <xsl:element name="StudyID">
            <xsl:value-of select="//OBR/OBR.19"/>
          </xsl:element>
          <xsl:element name="PatientIDIssuer"/>
          <xsl:element name="studycomments"/>
          <xsl:element name="sourceaetitle"/>
          <xsl:element name="PatientSex">
            <xsl:value-of select="//PID/PID.8"/>
          </xsl:element>
          <xsl:element name="PatientAge"/>
          <xsl:element name="BirthDate">
            <xsl:value-of select="//PID/PID.7"/>
          </xsl:element>
          <xsl:element name="StudyDttm">
            <xsl:value-of select="//OBX/OBX.14"/>
          </xsl:element>
          <!-- Modality : OT(Other) -->
          <xsl:element name="Modality">OT</xsl:element>
          <xsl:element name="AccessionNumber">
            <xsl:value-of select="//OBR/OBR.3"/>
          </xsl:element>
          <xsl:element name="StudyDesc"/>
          <xsl:element name="StudyInstanceUid">
            <xsl:value-of select="//ZDS/ZDS.1/ZDS.1.1"/>
          </xsl:element>
          <xsl:element name="Series">
            <xsl:element name="SeriesNumber"/>
            <xsl:element name="SeriesDesc"/>
            <xsl:element name="SeriesDttm">
              <xsl:value-of select="//OBX/OBX.14"/>
            </xsl:element>
            <!-- SeriesModality : OT(Other) -->
            <xsl:element name="SeriesModality">OT</xsl:element>
            <xsl:element name="Image">
              <!-- RemoveFile : 0 - Do Nothing, 1 - Delete -->
              <xsl:element name="RemoveFile">1</xsl:element>
              <!-- ImageCount : 1(File Count) -->
              <xsl:element name="ImageCount">1</xsl:element>              
              <!-- Filename : When you set the format, IntelliLink uses it to change the file name -->
              <!-- Default Format : FileCreationTime(yyyyMMddHHmmssfff)_PatId_AccessionNo_ReportApproveDate(yyyyMMdd)-->
              <xsl:element name="Filename">
                <xsl:value-of select="cs:DateTime_Now('yyyyMMddHHmmssfff')"/>_<xsl:value-of select="//PID/PID.3/PID.3.1"/>_<xsl:value-of select="//OBR[position()=1]/OBR.3"/>_<xsl:value-of select="substring(//OBR[position()=1]/OBR.22, 1, 8)"/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
