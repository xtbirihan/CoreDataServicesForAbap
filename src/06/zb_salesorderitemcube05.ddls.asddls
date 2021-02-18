// Calculation on row level (based on Cube04)

@AbapCatalog.sqlViewName: 'ZB_SOIC05'
@EndUserText.label: 'Analytic Cube 05 for Sales Order Items'

@Analytics.dataCategory: #CUBE

define view ZB_SalesOrderItemCube05
  as select from I_SalesOrderItem
  
  association [0..1] to I_CalendarDate as _CreationDate 
    on $projection.CreationDate = _CreationDate.CalendarDate
  
{
  SalesOrder,
  _SalesOrder,
  SalesOrderItem,
  CreationDate,
  _CreationDate.CalendarYear  as CreationYear,
  _CreationDate._CalendarYear as _CalendarYear,
  _CreationDate.WeekDay       as CreationWeekDay,
  _CreationDate._WeekDay      as _WeekDay,
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
  _TransactionCurrency,
  @Aggregation.default: #MIN
  division( NetAmount, OrderQuantity, 2 )  as AmountPerUnitMin,
  @Aggregation.default: #MAX
  division( NetAmount, OrderQuantity, 2 )  as AmountPerUnitMax
}
where OrderQuantity > 0
