<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- 1. Racine : squelette de la page + en-tête du tableau -->
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Rapport des mandats</title>
        <style>
          body  { font-family: Arial, sans-serif; margin: 30px; }
          h1    { color: #1f4e79; }
          table { border-collapse: collapse; }
          th, td { border: 1px solid #999; padding: 6px 12px; }
          th    { background: #1f4e79; color: white; }
          .recu    { color: #1e8449; font-weight: bold; }
          .nonrecu { color: #c0392b; font-weight: bold; }
          .total td { font-weight: bold; background: #dde7f2; }
        </style>
      </head>
      <body>
        <h1>Rapport des mandats</h1>
        <table>
          <tr>
            <th>N° mandat</th>
            <th>Date</th>
            <th>Expéditeur</th>
            <th>Destinataire</th>
            <th>Montant (DH)</th>
            <th>État</th>
          </tr>
          <xsl:apply-templates select="rapport/mandat"/>
          <tr class="total">
            <td colspan="4">Total des montants</td>
            <td><xsl:value-of select="sum(rapport/mandat/@montant)"/></td>
            <td><xsl:value-of select="count(rapport/mandat)"/> mandats</td>
          </tr>
        </table>
        <p>Mandats reçus : <xsl:value-of select="count(rapport/mandat[@etat='reçu'])"/></p>
      </body>
    </html>
  </xsl:template>

  <!-- 2. Un mandat = une ligne du tableau -->
  <xsl:template match="mandat">
    <tr>
      <td><xsl:value-of select="@num"/></td>
      <td><xsl:value-of select="@date"/></td>
      <td><xsl:apply-templates select="expediteur"/></td>
      <td><xsl:apply-templates select="destinataire"/></td>
      <td><xsl:value-of select="@montant"/></td>
      <td>
        <xsl:choose>
          <xsl:when test="@etat = 'reçu'">
            <span class="recu"><xsl:value-of select="@etat"/></span>
          </xsl:when>
          <xsl:otherwise>
            <span class="nonrecu"><xsl:value-of select="@etat"/></span>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <!-- 3. Une personne (expéditeur ou destinataire) -->
  <xsl:template match="expediteur | destinataire">
    <xsl:value-of select="concat(@prenom, ' ', @nom)"/><br/>
    CIN : <xsl:value-of select="@cin"/><br/>
    Ville : <xsl:value-of select="@ville"/>
  </xsl:template>

</xsl:stylesheet>
