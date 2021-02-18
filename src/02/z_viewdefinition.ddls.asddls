@AbapCatalog.sqlViewName: 'ZVIEWDEF'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Definition'
define view Z_ViewDefinition
  with parameters P_SalesOrderType : auart
  as select distinct from  ZI_SalesOrderItem as ITEM
    left outer to one join ZI_SalesOrder     as SO on SO.SalesOrder = ITEM.SalesOrder
    association [0..1] to ZI_Product as _Product on $projection.RenamedProduct = _Product.Product
{
  key ITEM.SalesOrder,
  key ITEM.Product                   as RenamedProduct,
      cast( 'A' as abap.char(2) )    as CalculatedField,
      count(*)                       as NumberOfAggregatedItems,
      ITEM._SalesOrder,
      _Product
}
where SO.SalesOrderType = $parameters.P_SalesOrderType
group by ITEM.SalesOrder,
         ITEM.Product
