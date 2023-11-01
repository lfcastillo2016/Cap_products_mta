sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'productsLFCR/project1/test/integration/FirstJourney',
		'productsLFCR/project1/test/integration/pages/ProductsList',
		'productsLFCR/project1/test/integration/pages/ProductsObjectPage',
		'productsLFCR/project1/test/integration/pages/ReviewsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage, ReviewsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('productsLFCR/project1') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage,
					onTheReviewsObjectPage: ReviewsObjectPage
                }
            },
            opaJourney.run
        );
    }
);