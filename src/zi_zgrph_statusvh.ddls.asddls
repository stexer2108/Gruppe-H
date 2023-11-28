@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Status'
define view entity ZI_ZGRPH_StatusVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZGRPH_CHAR_1')
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
      @EndUserText: { label: 'Status', quickInfo: 'Status' }
      value_low as Status,
      @EndUserText: { label: 'Status Text', quickInfo: 'Status Text' }
      text      as StatusText    
}
where
  language = $session.system_language
