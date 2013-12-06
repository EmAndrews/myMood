describe("index", function() {

    beforeEach(function() {
        loadFixtures('index.html');
        drawAdminPieChartIfAdmin();
        setCarouselToStopSpinning();
        removeStatusBarHandler();
        clickingOnSettingsHandler();
        clickingOnBrandHandler();
        clickingOnHomeHandler();
        goBackToSettingsAfterFailedChange();
    });

    it("should initially show line graph", function() {
        expect($('#line-graph').hasClass('active')).toBeTruthy();
        expect($('#pie-chart').hasClass('active')).toBeFalsy();
    });

    it("line graph should be active", function() {
        expect($('#line-graph').hasClass('active')).toBeTruthy();
    });

    it("pie chart shouldn't be active", function() {
        expect($('#pie-chart').hasClass('active')).toBeFalsy();
    });

    it("should go back to settings when clicking on the back to settings button", function() {
        $('#failed-change').click();
        expect($('#homepage-content').css('display') == 'none').toBeTruthy();
        expect($('#settings-content').css('display') == 'none').toBeFalsy();
    });

});