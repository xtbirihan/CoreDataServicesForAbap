// MIN / MAX aggregation of an average defined on row level of the cube view
@AbapCatalog.sqlViewName: 'ZB_SOIQ05'
@EndUserText.label: 'Query 05 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery05
  as select from ZB_SalesOrderItemCube05
  
{
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.display: #KEY_TEXT
  Material,
  _SalesOrganization._Text.SalesOrganizationName,
  @AnalyticsDetails.query.totals: #SHOW
  SoldToParty,
  @AnalyticsDetails.query.sortDirection: #ASC  
  _SoldToParty.CustomerName,
  OrderQuantity,
  OrderQuantityUnit,
  NetAmount,
  TransactionCurrency,
  @EndUserText.label: 'Minimal Amount per Unit'
  AmountPerUnitMin,
  @EndUserText.label: 'Maximal Amount per Unit'
  AmountPerUnitMax,
  @EndUserText.label: 'Average Amount per Unit'
  @AnalyticsDetails.query.formula: 'NetAmount / OrderQuantity'
  0 as AverageAmountPerUnit 
}

