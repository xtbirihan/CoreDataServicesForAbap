@AbapCatalog.sqlViewName: 'ZB_SOIQ03'
@EndUserText.label: 'Query 03 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery03
  with parameters
  
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_Today: abap.dats,
    
    @EndUserText.label: 'Country of Sold-To Party'
    @Consumption.valueHelpDefinition.entity: 
      { name: 'I_Country', element: 'Country' }
    @Consumption.defaultValue: 'DE'
    P_Country: land1_gp
    
  as select from ZB_SalesOrderItemCube04
  
{
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.display: #KEY_TEXT
  @Consumption.filter: { selectionType: #RANGE, multipleSelections: true }
  Material,
  @AnalyticsDetails.query.axis: #COLUMNS
  _SalesOrganization._Text.SalesOrganizationName,
  @AnalyticsDetails.query.totals: #SHOW
  @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true }
  SoldToParty,
  @AnalyticsDetails.query.sortDirection: #ASC  
  _SoldToParty.CustomerName,
  _SoldToParty.CityName,
  @EndUserText.label: 'Country of Sold-To Party'
  SoldToCountry,
  @AnalyticsDetails.query.axis: #ROWS
  @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false } 
  @Consumption.derivation: {
    lookupEntity: 'I_CalendarDate',
    resultElement: 'CalendarYear',
    binding: [ { targetElement: 'CalendarDate', type: #PARAMETER, value: 'P_Today' } ]
  }
  CreationYear,
  @AnalyticsDetails.query.hidden: true
  OrderQuantity,
  NetAmount
}
  where
    SoldToCountry = $parameters.P_Country

/*
Demonstrated functions of the analytci query:
- Hide a parameter
- Default value for a parameter from a system field
- Value help for a parameter
- Set a constant as default value for a parameter
- Define scope of a filter
- Derive the default value of a filter
- Use a filter in the where condition of the view
*/
