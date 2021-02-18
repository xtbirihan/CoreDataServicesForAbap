@AbapCatalog.sqlViewName: 'ZB_CUSTM'
@EndUserText.label: 'Customer'
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'Customer'

define view ZB_Customer as select from kna1

    association [0..1] to I_Country as _Country on $projection.Country = _Country.Country

{
      @ObjectModel.text.element: ['CustomerName']
  key cast( kunnr as kunnr preserving type ) as Customer,
      @Semantics.text:true
      cast( concat_with_space(name1, name2, 1) 
            as md_customer_name )         as CustomerName,

      @ObjectModel.foreignKey.association: '_Country'
      land1                               as Country,
      _Country,
      ort01                               as CityName

} 
