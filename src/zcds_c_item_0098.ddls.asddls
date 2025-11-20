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

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Name' },
      //                                            additionalBinding: [ { localElement: 'Description',
      //                                                                   element: 'Description',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
      //      @Search.defaultSearchElement: true
      //      @Semantics.name.fullName: true
      Name,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Description' },
      //                                            additionalBinding: [ { element: 'Height', usage: #RESULT },
      //                                                                 { localElement: 'Width',
      //                                                                   element: 'Width',
      //                                                                   usage: #RESULT },
      //                                                                 { localElement: 'Depth',
      //                                                                   element: 'Depth',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
      //      @Semantics.text: true
      Description,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'ReleaseDate' },
      //                                            additionalBinding: [ { localElement: 'DiscontinueDate',
      //                                                                   element: 'DiscontinueDate',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
      ReleaseDate,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'DiscontinueDate' },
      //                                            additionalBinding: [ { localElement: 'ReleaseDate',
      //                                                                   element: 'ReleaseDate',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
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

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Height' },
      //                                            useForValidation: true } ]
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Height,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' },
      //                                            additionalBinding: [ { localElement: 'UnitOfMeasureLongName',
      //                                                                   element: 'UnitOfMeasureLongName',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Width,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' },
      //                                            additionalBinding: [ { localElement: 'UnitOfMeasureLongName',
      //                                                                   element: 'UnitOfMeasureLongName',
      //                                                                   usage: #RESULT } ],
      //                                            useForValidation: true } ]
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Depth,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCDS_R_ITEM_0098', element: 'Quantity' },
      //                                            useForValidation: true } ]
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
