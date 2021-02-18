@AbapCatalog.sqlViewName: 'ZVIEWALTKEYS' 
@AbapCatalog.compiler.compareFilter: true 
@AccessControl.authorizationCheck: #NOT_REQUIRED 
@EndUserText.label: 'View with Alternative Keys' 
@ObjectModel.alternativeKey: [    { id : 'ObjectInternalID',     
                                    element : [ 'ObjectInternalID' ] },    
                                  { id : 'ObjectExternalKey',      
                                    element : [ 'ObjectID', 'ObjectVersion' ] } ]
define view Z_ViewWithAlternativeKeys
  as select distinct from t000
{
  key hextobin('00000000000000000000000000000001') as ObjectUUID,
      1                                            as ObjectInternalID,
      1                                            as ObjectID,
      1                                            as ObjectVersion
}
