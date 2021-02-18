// exception aggregation
@AbapCatalog.sqlViewName: 'ZB_SOIQ07'
@EndUserText.label: 'Query 07 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery07
  as select from ZB_SalesOrderItemCube04

{
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.display: #KEY_TEXT
  Material,
  _SalesOrganization._Text.SalesOrganizationName,
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  SoldToParty,
  @AnalyticsDetails.query.sortDirection: #ASC
  _SoldToParty.CustomerName,
  OrderQuantity,
  OrderQuantityUnit,
  NetAmount,
  TransactionCurrency,
  // Counter for different materials
  @EndUserText.label: 'Distinct Materials'
  @Aggregation.default: #FORMULA
  @AnalyticsDetails: { 
    exceptionAggregationSteps: [{
      exceptionAggregationBehavior: #COUNT,
      exceptionAggregationElements: [ 'Material' ]
    }] 
  }
  0 as NumberOfDistinctMaterials //value makes no difference for #COUNT but for #SUM
}
