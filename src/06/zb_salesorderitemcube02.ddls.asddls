// Cube without dimension meta data
@AbapCatalog.sqlViewName: 'ZB_SOIC02'
@EndUserText.label: 'Analytic Cube 02 for Sales Order Items'

@Analytics.dataCategory: #CUBE

@Metadata.ignorePropagatedAnnotations: true

define view ZB_SalesOrderItemCube02
  as select from I_SalesOrderItem
  
{
  SalesOrder,
  _SalesOrder,
  SalesOrderItem,
  CreationDate,
  _SalesOrder.SalesOrganization, 
  _SalesOrder._SalesOrganization,
  _SalesOrder.SoldToParty,
  _SalesOrder._SoldToParty,
  _SalesOrder._SoldToParty.Country as SoldToCountry, 
  Material, 
  _Material, 
  @Aggregation.default: #SUM
  OrderQuantity, 
  OrderQuantityUnit,
  _OrderQuantityUnit,
  @Aggregation.default: #SUM
  NetAmount, 
  TransactionCurrency, 
  _TransactionCurrency
}
