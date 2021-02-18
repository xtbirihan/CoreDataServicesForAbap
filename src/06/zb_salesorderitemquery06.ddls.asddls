// restricted measures
@AbapCatalog.sqlViewName: 'ZB_SOIQ06'
@EndUserText.label: 'Query 06 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery06
  as select from ZB_SalesOrderItemCube04
  
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
  @AnalyticsDetails.query.display: #TEXT
  CreationWeekDay,
  OrderQuantity,
  OrderQuantityUnit,
  NetAmount,
  TransactionCurrency,
  @EndUserText.label: 'MO-WE Quantity'
  case when CreationWeekDay <= '3' then OrderQuantity else 0 end as MondayToWednesdayQuantity,
  @EndUserText.label: 'TH-SU Quantity'
  case when CreationWeekDay >= '4' then OrderQuantity else 0 end as ThursdayToSundayQuantity,
  @EndUserText.label: 'MO-WE Value'
  case when CreationWeekDay <= '3' then NetAmount else 0 end as MondayToWednesdayAmount,
  @EndUserText.label: 'TH-SU Value'
  case when CreationWeekDay >= '4' then NetAmount else 0 end as ThursdayToSundayAmount
}
