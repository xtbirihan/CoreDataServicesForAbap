@AbapCatalog.sqlViewName: 'ZB_SALESORG'
@EndUserText.label: 'Sales Organization'
//@EndUserText.label: 'Verkaufsorganisation'
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'SalesOrganization'

define view ZB_SalesOrganization
  as select from tvko
  association [0..*] to ZB_SalesOrganizationText as _Text on $projection.SalesOrganization = _Text.SalesOrganization
{
      @ObjectModel.text.association: '_Text'
  key vkorg as SalesOrganization,
      waers as SalesOrganizationCurrency,
      _Text
}
