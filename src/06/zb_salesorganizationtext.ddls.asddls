@AbapCatalog.sqlViewName: 'ZB_SALESORGTEXT'
@EndUserText.label: 'Sales Organization Text'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'SalesOrganization'

define view ZB_SalesOrganizationText
  as select from tvkot
  association [0..1] to ZB_SalesOrganization as _SalesOrganization on $projection.SalesOrganization = _SalesOrganization.SalesOrganization
  association [0..1] to I_Language           as _Language          on $projection.Language = _Language.Language
{
      @ObjectModel.foreignKey.association: '_SalesOrganization'
  key vkorg as SalesOrganization, _SalesOrganization,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras as Language, _Language,
      @Semantics.text: true
      vtext as SalesOrganizationName
}
 