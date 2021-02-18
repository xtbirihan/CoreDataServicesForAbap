// Cube with explicit dimension meta data
@AbapCatalog.sqlViewName: 'ZB_SOIC03'
@EndUserText.label: 'Analytic Cube 03 for Sales Order Items'
@Analytics.dataCategory: #CUBE
@Metadata.ignorePropagatedAnnotations: true

define view ZB_SalesOrderItemCube03
  as select from I_SalesOrderItem
  
{
  @ObjectModel.foreignKey.association: '_SalesOrder'
  SalesOrder,
  _SalesOrder,
  SalesOrderItem,
  CreationDate,
  @ObjectModel.foreignKey.association: '_SalesOrganization'
  _SalesOrder.SalesOrganization, 
  _SalesOrder._SalesOrganization,
  @ObjectModel.foreignKey.association: '_SoldToParty'
  _SalesOrder.SoldToParty,
  _SalesOrder._SoldToParty,
  _SalesOrder._SoldToParty.Country as SoldToCountry, 
  @ObjectModel.foreignKey.association: '_Material'
  Material, 
  _Material, 
  @Aggregation.default: #SUM
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  OrderQuantity, 
  @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
  @Semantics.unitOfMeasure: true
  OrderQuantityUnit,
  _OrderQuantityUnit,
  @Aggregation.default: #SUM
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  NetAmount, 
  @ObjectModel.foreignKey.association: '_TransactionCurrency'
  @Semantics.currencyCode: true
  TransactionCurrency, 
  _TransactionCurrency
}
