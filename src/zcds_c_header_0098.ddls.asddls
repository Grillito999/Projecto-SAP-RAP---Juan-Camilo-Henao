@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Header Comsuption Entity- 0098'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true

define root view entity ZCDS_C_HEADER_0098
  provider contract transactional_query
  as projection on ZCDS_R_HEADER_0098

{

  key HeaderUUID,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'HeaderId' },
                                            additionalBinding: [ { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT },
                                                                 { localElement: 'FirstName',
                                                                   element: 'FirstName',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Search.defaultSearchElement: true
      HeaderId,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'Email' },
                                            additionalBinding: [ { localElement: 'FirstName',
                                                                   element: 'FirstName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'LastName',
                                                                   element: 'LastName',
                                                                   usage: #RESULT } ] } ]
      @Semantics.eMail.address: true
      Email,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'FirstName' },
                                            additionalBinding: [ { localElement: 'LastName',
                                                                   element: 'LastName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ] } ]
      @Semantics.name.prefix: true
      FirstName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'LastName' },
                                            additionalBinding: [ { localElement: 'FirstName',
                                                                   element: 'FirstName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ] } ]
      @Semantics.name.suffix: true
      LastName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CountryVH', element: 'Country' } } ]
      @Semantics.address.country: true
      Country,

      CreateOn,

      DeliveryDate,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_OrderStatusVH_0098', element: 'Orderstatus' },
                                            additionalBinding: [ { localElement: 'DescriptionStatus',
                                                                   element: 'Description',
                                                                   usage: #RESULT } ] } ]
      OrderStatus,

      _orderStatus.Description as DescriptionStatus,

      ImageUrl,

      /* Associations */
      _Items : redirected to composition child ZCDS_C_ITEM_0098,

      _Country
}
