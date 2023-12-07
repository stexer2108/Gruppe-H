@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Status'
define view entity zi_zgrph_StatusVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZGRPH_CHAR_1')
{
  key domain_name    as DomainName,
  key value_position as ValuePosition,
  key language       as Language,
      value_low      as ValueLow,
      text           as StatusText,
      
      concat_with_space( text, '', 1) as StatusName
}
where
  language = $session.system_language
