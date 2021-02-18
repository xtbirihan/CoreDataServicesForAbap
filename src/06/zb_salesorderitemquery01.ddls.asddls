// Pure projection
@AbapCatalog.sqlViewName: 'ZB_SOIQ01'
@EndUserText.label: 'Query 01 for Sales Order Items'

@Analytics.query: true

define view ZB_SalesOrderItemQuery01
  as select from ZB_SalesOrderItemCube01
  
{
  Material,
  SoldToParty,
  SoldToCountry,
  OrderQuantity,
  NetAmount
}

