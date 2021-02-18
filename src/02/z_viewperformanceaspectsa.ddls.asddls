@AbapCatalog.sqlViewName: 'ZVIEWPERFASPA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Performance Aspects A'
define view Z_ViewPerformanceAspectsA
  //used by option 1
  as select from           ZI_SalesOrderItem as SOI
  //used by option 2
    left outer to one join ZI_ProductText    as PT on PT.Product  = SOI.Product
                                                  and PT.Language = 'E'
  //used by option 3
  association [0..*] to ZI_ProductText as _ProductText on $projection.Product = _ProductText.Product
{
  key SalesOrder,
  key SOI.SalesOrderItem,
      @ObjectModel.text.association: '_ProductText'
      SOI.Product,
      cast( SOI.Product as abap.char(20))            as CastProduct,
      //option 1
      SOI._Product._Text[1:Language='E'].ProductName as ProductNameInEnglish1,
      //option 2
      _ProductText[1:Language='E'].ProductName       as ProductNameInEnglish2,
      //option 3
      PT.ProductName                                 as ProductNameInEnglish3,
      _ProductText
}
