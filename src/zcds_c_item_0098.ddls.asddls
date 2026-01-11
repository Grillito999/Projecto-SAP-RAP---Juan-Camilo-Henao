@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Item Comsuption Entity- 0098'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true

define view entity ZCDS_C_ITEM_0098
  as projection on ZCDS_R_ITEM_0098

{
  key ItemUUID,

      HeaderUUID,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'ItemID' },
                                            additionalBinding: [ { localElement: 'Name', element: 'Name', usage: #RESULT },
                                                                 { localElement: 'Description',
                                                                   element: 'Description',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]
      @Search.defaultSearchElement: true

      ItemID,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Name' },
                                            additionalBinding: [ { localElement: 'Description',
                                                                   element: 'Description',
                                                                   usage: #RESULT } ] } ]
      @Semantics.name.fullName: true
      Name,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Description' },
                                            additionalBinding: [ { element: 'Height', usage: #RESULT },
                                                                 { localElement: 'Width',
                                                                   element: 'Width',
                                                                   usage: #RESULT },
                                                                 { localElement: 'Depth',
                                                                   element: 'Depth',
                                                                   usage: #RESULT } ] } ]
      @Semantics.text: true
      Description,

      ReleaseDate,

      DiscontinueDate,

      _Currency._Text.CurrencyName       as CurrencyName : localized,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Price' },
                                            additionalBinding: [ { localElement: 'Currency',
                                                                   element: 'Currency',
                                                                   usage: #RESULT },
                                                                 { element: 'CurrencyName', usage: #RESULT } ],
                                            useForValidation: true } ]

      @Semantics.amount.currencyCode: 'Currency'
      Price,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'Currency' },
                                            additionalBinding: [ { element: 'CurrencyName', usage: #RESULT } ],
                                            useForValidation: true } ]
      Currency,


      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Height,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Width,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Depth,

      Quantity,

      _UnitMeasure.UnitOfMeasureLongName as UnitOfMeasureLongName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' },
                                            additionalBinding: [ { localElement: 'UnitOfMeasureLongName',
                                                                   element: 'UnitOfMeasureLongName',
                                                                   usage: #RESULT } ],
                                            useForValidation: true } ]

      UnitOfMeasure,

      /* Associations */
      _Header : redirected to parent ZCDS_C_HEADER_0098,

      _Currency,
      _UnitMeasure
}
