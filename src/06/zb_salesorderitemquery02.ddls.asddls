// Initial layout, sorting
// Choose ID, text, attributes for display
@AbapCatalog.sqlViewName: 'ZB_SOIQ02'
@EndUserText.label: 'Query 02 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery02
  as select from ZB_SalesOrderItemCube01
  
{
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.display: #KEY_TEXT
  Material,
  @AnalyticsDetails.query.axis: #COLUMNS
  _SalesOrganization._Text.SalesOrganizationName,
  @AnalyticsDetails.query.totals: #SHOW
  SoldToParty,
  @AnalyticsDetails.query.sortDirection: #ASC  
  _SoldToParty.CustomerName,
  _SoldToParty.CityName,
  @EndUserText.label: 'Country of Sold-To Party'
  SoldToCountry,
  @AnalyticsDetails.query.hidden: true
  OrderQuantity,
  NetAmount
}

/*
Demonstrated layout functions of the analytic query:
- initial distribution of measures and dimension to rows or columns
- initial definition of subtotals for dimensions
- initial selection of ID/text display for dimensions by an annotation
- initial selection of ID/text display for dimensions by path notation
  Attention: warning
- initial sorting by a dimension text
- initial display of a dimension attribute by path notation
- definition of a field label
- initial hiding of a measure (can be inserted by the user)

*/
