using {com.lfcr as lfcr} from '../db/schema';

// service CatalogService {
// entity Products          as projection on lfcr.materials.Products;
// entity Suppliers         as projection on lfcr.sales.Suppliers;
// entity StockAvailability as projection on lfcr.materials.StockAvailability;
// entity Currency          as projection on lfcr.materials.Currencies;
// entity UnitOfMeasures    as projection on lfcr.materials.UnitOfMeasures;
// entity DimensionUnit     as projection on lfcr.materials.DimensionUnits;
// entity Category          as projection on lfcr.materials.Categories;
// entity Months            as projection on lfcr.sales.Months;
// entity Reviews           as projection on lfcr.materials.ProductReview;
// entity SalesData         as projection on lfcr.sales.SalesData;
// entity Order             as projection on lfcr.sales.Orders;
// entity OrderItem         as projection on lfcr.sales.OrderItems;

// }

define service MyService {

    //Entidad PRODUCTOS
    entity Products          as
        select from lfcr.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity,
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category      as ToCategory      @mandatory,
            Category.ID   as CategoryId,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailibilty
              };

    // ENTIDAD SUPLIER
    @readonly
    entity Supplier          as
        select from lfcr.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };


    // ENTIDAD REVIEWS
    entity Reviews           as
        select from lfcr.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as Toproduct
        };

    // ENTIDAD SALESDATA
    @readonly
    entity SalesData         as
        select from lfcr.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    //ENTIDAD STOCL AVAILABILITY
    @readonly
    entity StockAvailability as
        select from lfcr.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    // AYUDAS DE BUSQUEDA
    @readonly
    entity VH_Categories     as
        select from lfcr.materials.Categories {
            ID   as Code,
            Name as Text
        };

    // AYUDAS DE BUSQUEDA
    @readonly
    entity VH_Currencies     as
        select from lfcr.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    // AYUDAS DE BUSQUEDA
    @readonly
    entity VH_UnitOfMeasure  as
        select from lfcr.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    // AYUDAS DE BUSQUEDA
    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from lfcr.materials.DimensionUnits;
}

define service MyServiceLFCR {

    entity SuppliersProduct  as
        select from lfcr.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.PostalCode
        }
        where
            Supplier.PostalCode = 98074;

    // ENTITY INFIX - PRUEBAS ADICIONALES
    entity EntityInfix       as
        select Supplier[Name = 'Exotic Liquids'].Phone from lfcr.materials.Products
        where
            Products.Name = 'Bread';

    // ENTITY CON JOIN - PRUEBAS JOIN
    entity EntityJoin        as
        select Phone from lfcr.materials.Products
        left join lfcr.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';


};

define service Reports {
    entity AverageRating     as projection on lfcr.reports.AverageRating;

    entity EntityCasting     as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from lfcr.materials.Products;


    entity EntityExists      as
        select from lfcr.materials.Products {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids'];


};
