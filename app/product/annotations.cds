using MyService as service from '../../srv/catalog-service';

annotate service.Products with @(

    // Para deshabilitar en este caso el boto de DELETE
    Capabilities      : {DeleteRestrictions: {
        $Type    : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }, },

    UI.HeaderInfo     : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },

    UI.SelectionFields: [
        CategoryId,
        CurrencyId,
        StockAvailability
    ],


    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ImageUrl}',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ProductName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>Supplier}',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ReleaseDate}',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DiscontinuedDate}',
            Value: DiscontinuedDate,
        },
        {
            Label      : '{i18n>StockAvailability}',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },

        {
            // $Type: 'UI.DataField',
            Label : '{i18n>Rating}',
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'
        // Value: Rating
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Price}',
            Value: Price
        },
    ]
);

//Para validar el tema de los titulos enlos parametros
annotate service.Products with {
    CategoryId       @title: '{i18n>Category}';
    CurrencyId       @title: '{i18n>Currency}';
    StockAvailability @title: '{i18n>StockAvailability}';
};

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'ProductName',
            //     Value: ProductName,
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'Description',
            //     Value: Description,
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'ImageUrl',
            //     Value: ImageUrl,
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ReleaseDate}',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DiscontinuedDate}',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Price}',
                Value: Price,
            },

            //Se comenta esta linea para solo mostrarla a nivel de cabecera
            // {
            //     Label : 'Rating',
            //     $Type : 'UI.DataFieldForAnnotation',
            //     Target: '@UI.DataPoint#AverageRating'
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Height}',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Width}',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Depth}',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Quantity}',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToUnitOfMeasure_ID}',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToCurrency_ID}',
                Value: ToCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToCategory_ID}',
                Value: ToCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Category}',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToDimensionUnit_ID}',
                Value: ToDimensionUnit_ID,
            },
        ],
    },

    // Agrupar los datos de posicion (PEstañas)
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ],

    //Para subir a nivel de cabecera alguno datos de posicion
    UI.HeaderFacets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AverageRating'
    }, ]

);

//Para configurar el campo de imagen
annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};


//Ayudas de busqueda
annotate service.Products with {
    // Ayuda para el campo Currency
    ToCategory        @(Common: {
        Text     : {
            $value                 : Category,
            ![@UI.TextArrangement] : #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //Ayuda para el campo Currency
    ToCurrency        @(Common: {

        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    // Ayuda de busqueda para Stock Availability
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'ID'
            },
            /*             {
                             $Type            : 'Common.ValueListParameterInOut',
                             LocalDataProperty: StockAvailability,
                             ValueListProperty: 'Description'
                         }*/
            ]
        },
    })

};

/**
 * Annotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                 : Text,
            ![@UI.TextArrangement] : #TextOnly,
        }}
    );
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for VH_Curency Entity
 */
annotate service.VH_Currencies {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
}

/**
 * Annotations for StockAvailability
 */
annotate service.StockAvailability {
    ID @(Common: {Text: {
        $value                 : Description,
        ![@UI.TextArrangement] : #TextOnly,
    }})
}

/**
 * Annotations for annotate service.VH_UnitOfMeasure Entity
 */
annotate service.VH_UnitOfMeasure {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
}

/**
 * Annotations for annotate service.VH_UnitOfMeasure Entity
 */
annotate service.VH_DimensionUnits {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
}

/**
 * Annotations for supplier entity
 */
annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]
}, });

/**
 * Data Point for Average Rating
 */
annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Rating,
    Title        : 'Rating',
    TargetValue  : 5,
    Visualization: #Rating
});
