// exception aggregation: sum distinct
@AbapCatalog.sqlViewName: 'ZB_SOIQ08'
@EndUserText.label: 'Query 08 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery08
  as select from ZB_SalesOrderItemCube06

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
  @AnalyticsDetails.query.totals: #SHOW
  SalesOrder,
  OrderQuantity,
  NetAmount,
  @EndUserText.label: 'Maximal Order Net Value'
  @AnalyticsDetails.query.hidden: true
  TotalNetAmount,
  // (distinctly) aggregated TotalNetAmount
  @EndUserText.label: 'Total Order Net Value'
  @AnalyticsDetails: { 
    exceptionAggregationSteps: [{
      exceptionAggregationBehavior: #SUM,
      exceptionAggregationElements: [ 'SalesOrder' ]
    }] 
  }
  @AnalyticsDetails.query.formula: 'TotalNetAmount'
  0 as DistinctTotalNetAmount
}
