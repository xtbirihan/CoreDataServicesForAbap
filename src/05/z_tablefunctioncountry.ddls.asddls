@ClientHandling.type:      #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE

define table function Z_TableFunctionCountry
  with parameters
    @Environment.systemField: #CLIENT
    P_SAPClient : vdm_v_sap_client
returns
{
  mandt                     : vdm_v_sap_client;
  Country                   : land1_gp;
  CountryCurrency           : waers_005;
  IndexBasedCurrency        : curin;
  HardCurrency              : curha;
  TaxCalculationProcedure   : kalsm_d;
  CountryThreeLetterISOCode : intca3;
  CountryThreeDigitISOCode  : intcn3;
}
implemented by method
  zcl_table_function_country=>get_countries
