describe("index", function() {

    beforeEach(function() {
        loadFixtures('index.html');
        drawAdminPieChartIfAdmin();
        setCarouselToStopSpinning();
        removeStatusBarHandler();
        goBackToSettingsAfterFailedChange();
        clickingOnSettingsHandler();
        clickingOnBrandHandler();
        clickingOnHomeHandler();
    });

    it("line graph should be active", function() {
        expect($('#line-graph').hasClass('active')).toBeTruthy();
    });

    it("pie chart shouldn't be active", function() {
        expect($('#pie-chart').hasClass('active')).toBeFalsy();
    });
});