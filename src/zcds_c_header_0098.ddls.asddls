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
                                            additionalBinding: [ { localElement: 'ItemId',
                                                                   element: 'ItemId',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Search.defaultSearchElement: true
      HeaderId,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'ItemId' },
                                            additionalBinding: [ { localElement: 'HeaderId',
                                                                   element: 'HeaderId',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Search.defaultSearchElement: true
      ItemId,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'Email' },
                                            additionalBinding: [ { localElement: 'FirstName',
                                                                   element: 'FirstName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'LastName',
                                                                   element: 'LastName',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Semantics.eMail.address: true
      Email,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'FirstName' },
                                            additionalBinding: [ { localElement: 'LastName',
                                                                   element: 'LastName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Semantics.name.prefix: true
      FirstName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'LastName' },
                                            additionalBinding: [ { localElement: 'FirstName',
                                                                   element: 'FirstName',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Email',
                                                                   element: 'Email',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Semantics.name.suffix: true
      LastName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CountryVH', element: 'Country' },
                                            additionalBinding: [ { localElement: 'IsoDigitCode',
                                                                   element: 'CountryThreeDigitISOCode',
                                                                   usage: #RESULT },
                                                                 { localElement: 'IsoLetterCode',
                                                                   element: 'CountryThreeLetterISOCode',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Semantics.address.country: true
      Country,

      _Country.CountryThreeDigitISOCode  as IsoDigitCode,
      _Country.CountryThreeLetterISOCode as IsoLetterCode,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'CreateOn' },
                                            additionalBinding: [ { localElement: 'DeliveryDate',
                                                                   element: 'DeliveryDate',
                                                                   usage: #RESULT },
                                                                 { localElement: 'OrderStatus',
                                                                   element: 'OrderStatus',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      CreateOn,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'DeliveryDate'},
                                            additionalBinding: [ { localElement: 'CreateOn',
                                                                   element: 'CreateOn',
                                                                   usage: #RESULT },
                                                                 { localElement: 'OrderStatus',
                                                                   element: 'OrderStatus',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      DeliveryDate,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_HEADER_0098', element: 'OrderStatus' },
                                            additionalBinding: [ { localElement: 'CreateOn',
                                                                   element: 'CreateOn',
                                                                   usage: #RESULT },
                                                                 { localElement: 'DeliveryDate',
                                                                   element: 'DeliveryDate',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      OrderStatus,

      @Semantics.imageUrl: true
      ImageUrl,

      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _Items : redirected to composition child ZCDS_C_ITEM_0098,
      _Country

}
