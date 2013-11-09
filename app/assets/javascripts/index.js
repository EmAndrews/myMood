function draw_group_graph(name, dataset) {

    var dateFormat = d3.time.format("%Y-%m-%d");

    var margin = {top: 20, right: 80, bottom: 30, left: 50},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    var nestedData = d3.nest()
        .key(function (d) {
            return d.id;
        })
        .key(function (d) {
            return dateFormat(new Date(d.time));
        })
        .key(function (d) {
            return d.score
        })
        .entries(dataset);

    minDate = new Date();
    minDate.setDate((new Date(dataset[0].time)).getDate() + 1);
    maxDate = new Date();
    maxDate.setDate((new Date(dataset[dataset.length - 1].time)).getDate());

    var x = d3.time.scale()
        .domain([minDate, maxDate])
        .nice(d3.time.day)
        .range([0, width]);

    var y = d3.scale.linear().domain([0, 10]).range([height, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .ticks(d3.time.days, 0)
        .tickFormat(dateFormat)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var color = d3.scale.category10();

    var div_to_add_to = "#" + name;

    var svg = d3.select(div_to_add_to).append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    drawMainGraph();

    function drawMainGraph() {

        var line = d3.svg.line()
            .interpolate("linear")
            .x(function (d) {
                return x(dateFormat.parse(d.key))
            })
            .y(function (d) {
                return y(d.values[0].key)
            });

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append("g")
            .attr("class", "y axis")
            .call(yAxis)
            .append("text")
            .attr("transform", "rotate(-90)")
            .attr("y", 6)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .text("Score");


        var scoreLine = svg.selectAll(".score")
            .data(nestedData)
            .enter()
            .append("g")
            .attr("class", "score")
            .attr("transform", "translate(277,0)")
            .attr("id", function (d) {
                return "score-" + d.key
            });

        scoreLine.append("path")
            .attr("class", "line")
            .attr("d", function (d) {
                return line(d.values);
            })
            .style("stroke", function (d) {
                return color(d.key);
            });
    }
}

var user_dataset = [
    {"id": 110, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 110, "time": "2013-10-13", "score": 10, "userName": "Alice"},
    {"id": 110, "time": "2013-10-14", "score": 6, "userName": "Alice"},
    {"id": 110, "time": "2013-10-15", "score": 4, "userName": "Alice"}
];

var admin_group_dataset = [
    {"id": 110, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 115, "time": "2013-10-12", "score": 3, "userName": "Clyde"},
    {"id": 111, "time": "2013-10-12", "score": 5, "userName": "Bob"},
    {"id": 110, "time": "2013-10-13", "score": 10, "userName": "Alice"},
    {"id": 115, "time": "2013-10-13", "score": 7, "userName": "Clyde"},
    {"id": 111, "time": "2013-10-13", "score": 9, "userName": "Bob"},
    {"id": 110, "time": "2013-10-14", "score": 6, "userName": "Alice"},
    {"id": 115, "time": "2013-10-14", "score": 10, "userName": "Clyde"},
    {"id": 111, "time": "2013-10-14", "score": 2, "userName": "Bob"},
    {"id": 110, "time": "2013-10-15", "score": 4, "userName": "Alice"},
    {"id": 115, "time": "2013-10-15", "score": 7, "userName": "Clyde"},
    {"id": 111, "time": "2013-10-15", "score": 8, "userName": "Bob"}
];

//12 members 3 inactive
var blue_group_dataset = [
    {"id": 1, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 2, "time": "2013-10-12", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-12", "score": 5, "userName": "Bob"},
    {"id": 4, "time": "2013-10-12", "score": 10, "userName": "Roger"},
    {"id": 5, "time": "2013-10-12", "score": 7, "userName": "Simon"},
    {"id": 6, "time": "2013-10-12", "score": 9, "userName": "Dan"},
    {"id": 7, "time": "2013-10-12", "score": 6, "userName": "Jim"},
    {"id": 8, "time": "2013-10-12", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-12", "score": 2, "userName": "Brian"},
    {"id": 1, "time": "2013-10-13", "score": 8, "userName": "Alice"},
    {"id": 2, "time": "2013-10-13", "score": 8, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-13", "score": 2, "userName": "Bob"},
    {"id": 4, "time": "2013-10-13", "score": 3, "userName": "Roger"},
    {"id": 5, "time": "2013-10-13", "score": 6, "userName": "Simon"},
    {"id": 6, "time": "2013-10-13", "score": 5, "userName": "Dan"},
    {"id": 7, "time": "2013-10-13", "score": 7, "userName": "Jim"},
    {"id": 8, "time": "2013-10-13", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-13", "score": 4, "userName": "Brian"},
    {"id": 1, "time": "2013-10-14", "score": 9, "userName": "Alice"},
    {"id": 2, "time": "2013-10-14", "score": 2, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-14", "score": 7, "userName": "Bob"},
    {"id": 4, "time": "2013-10-14", "score": 9, "userName": "Roger"},
    {"id": 5, "time": "2013-10-14", "score": 9, "userName": "Simon"},
    {"id": 6, "time": "2013-10-14", "score": 6, "userName": "Dan"},
    {"id": 7, "time": "2013-10-14", "score": 8, "userName": "Jim"},
    {"id": 8, "time": "2013-10-14", "score": 4, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-14", "score": 6, "userName": "Brian"},
    {"id": 1, "time": "2013-10-15", "score": 5, "userName": "Alice"},
    {"id": 2, "time": "2013-10-15", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-15", "score": 8, "userName": "Bob"},
    {"id": 4, "time": "2013-10-15", "score": 7, "userName": "Roger"},
    {"id": 5, "time": "2013-10-15", "score": 5, "userName": "Simon"},
    {"id": 6, "time": "2013-10-15", "score": 7, "userName": "Dan"},
    {"id": 7, "time": "2013-10-15", "score": 9, "userName": "Jim"},
    {"id": 8, "time": "2013-10-15", "score": 5, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-15", "score": 6, "userName": "Brian"}
];

//10 members 0 inactive
var green_group_dataset = [
    {"id": 1, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 2, "time": "2013-10-12", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-12", "score": 5, "userName": "Bob"},
    {"id": 4, "time": "2013-10-12", "score": 10, "userName": "Roger"},
    {"id": 5, "time": "2013-10-12", "score": 7, "userName": "Simon"},
    {"id": 6, "time": "2013-10-12", "score": 9, "userName": "Dan"},
    {"id": 7, "time": "2013-10-12", "score": 6, "userName": "Jim"},
    {"id": 8, "time": "2013-10-12", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-12", "score": 2, "userName": "Brian"},
    {"id": 10, "time": "2013-10-12", "score": 5, "userName": "Hank"},
    {"id": 1, "time": "2013-10-13", "score": 8, "userName": "Alice"},
    {"id": 2, "time": "2013-10-13", "score": 8, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-13", "score": 2, "userName": "Bob"},
    {"id": 4, "time": "2013-10-13", "score": 3, "userName": "Roger"},
    {"id": 5, "time": "2013-10-13", "score": 6, "userName": "Simon"},
    {"id": 6, "time": "2013-10-13", "score": 5, "userName": "Dan"},
    {"id": 7, "time": "2013-10-13", "score": 7, "userName": "Jim"},
    {"id": 8, "time": "2013-10-13", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-13", "score": 4, "userName": "Brian"},
    {"id": 10, "time": "2013-10-13", "score": 7, "userName": "Hank"},
    {"id": 1, "time": "2013-10-14", "score": 9, "userName": "Alice"},
    {"id": 2, "time": "2013-10-14", "score": 2, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-14", "score": 7, "userName": "Bob"},
    {"id": 4, "time": "2013-10-14", "score": 9, "userName": "Roger"},
    {"id": 5, "time": "2013-10-14", "score": 9, "userName": "Simon"},
    {"id": 6, "time": "2013-10-14", "score": 6, "userName": "Dan"},
    {"id": 7, "time": "2013-10-14", "score": 8, "userName": "Jim"},
    {"id": 8, "time": "2013-10-14", "score": 4, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-14", "score": 6, "userName": "Brian"},
    {"id": 10, "time": "2013-10-14", "score": 8, "userName": "Hank"},
    {"id": 1, "time": "2013-10-15", "score": 5, "userName": "Alice"},
    {"id": 2, "time": "2013-10-15", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-15", "score": 8, "userName": "Bob"},
    {"id": 4, "time": "2013-10-15", "score": 7, "userName": "Roger"},
    {"id": 5, "time": "2013-10-15", "score": 5, "userName": "Simon"},
    {"id": 6, "time": "2013-10-15", "score": 7, "userName": "Dan"},
    {"id": 7, "time": "2013-10-15", "score": 9, "userName": "Jim"},
    {"id": 8, "time": "2013-10-15", "score": 5, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-15", "score": 6, "userName": "Brian"},
    {"id": 10, "time": "2013-10-15", "score": 6, "userName": "Hank"}
];

var red_group_dataset = [
    {"id": 1, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 2, "time": "2013-10-12", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-12", "score": 5, "userName": "Bob"},
    {"id": 4, "time": "2013-10-12", "score": 10, "userName": "Roger"},
    {"id": 5, "time": "2013-10-12", "score": 7, "userName": "Simon"},
    {"id": 6, "time": "2013-10-12", "score": 9, "userName": "Dan"},
    {"id": 7, "time": "2013-10-12", "score": 6, "userName": "Jim"},
    {"id": 1, "time": "2013-10-13", "score": 8, "userName": "Alice"},
    {"id": 2, "time": "2013-10-13", "score": 8, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-13", "score": 2, "userName": "Bob"},
    {"id": 4, "time": "2013-10-13", "score": 3, "userName": "Roger"},
    {"id": 5, "time": "2013-10-13", "score": 6, "userName": "Simon"},
    {"id": 6, "time": "2013-10-13", "score": 5, "userName": "Dan"},
    {"id": 7, "time": "2013-10-13", "score": 7, "userName": "Jim"},
    {"id": 1, "time": "2013-10-14", "score": 9, "userName": "Alice"},
    {"id": 2, "time": "2013-10-14", "score": 2, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-14", "score": 7, "userName": "Bob"},
    {"id": 4, "time": "2013-10-14", "score": 9, "userName": "Roger"},
    {"id": 5, "time": "2013-10-14", "score": 9, "userName": "Simon"},
    {"id": 6, "time": "2013-10-14", "score": 6, "userName": "Dan"},
    {"id": 7, "time": "2013-10-14", "score": 8, "userName": "Jim"},
    {"id": 1, "time": "2013-10-15", "score": 5, "userName": "Alice"},
    {"id": 2, "time": "2013-10-15", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-15", "score": 8, "userName": "Bob"},
    {"id": 4, "time": "2013-10-15", "score": 7, "userName": "Roger"},
    {"id": 5, "time": "2013-10-15", "score": 5, "userName": "Simon"},
    {"id": 6, "time": "2013-10-15", "score": 7, "userName": "Dan"},
    {"id": 7, "time": "2013-10-15", "score": 9, "userName": "Jim"}

];

var purple_group_dataset = [
    {"id": 1, "time": "2013-10-12", "score": 4, "userName": "Alice"},
    {"id": 2, "time": "2013-10-12", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-12", "score": 5, "userName": "Bob"},
    {"id": 4, "time": "2013-10-12", "score": 10, "userName": "Roger"},
    {"id": 5, "time": "2013-10-12", "score": 7, "userName": "Simon"},
    {"id": 6, "time": "2013-10-12", "score": 9, "userName": "Dan"},
    {"id": 7, "time": "2013-10-12", "score": 6, "userName": "Jim"},
    {"id": 8, "time": "2013-10-12", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-12", "score": 2, "userName": "Brian"},
    {"id": 10, "time": "2013-10-12", "score": 5, "userName": "Hank"},
    {"id": 1, "time": "2013-10-13", "score": 8, "userName": "Alice"},
    {"id": 2, "time": "2013-10-13", "score": 8, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-13", "score": 2, "userName": "Bob"},
    {"id": 4, "time": "2013-10-13", "score": 3, "userName": "Roger"},
    {"id": 5, "time": "2013-10-13", "score": 6, "userName": "Simon"},
    {"id": 6, "time": "2013-10-13", "score": 5, "userName": "Dan"},
    {"id": 7, "time": "2013-10-13", "score": 7, "userName": "Jim"},
    {"id": 8, "time": "2013-10-13", "score": 10, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-13", "score": 4, "userName": "Brian"},
    {"id": 10, "time": "2013-10-13", "score": 7, "userName": "Hank"},
    {"id": 1, "time": "2013-10-14", "score": 9, "userName": "Alice"},
    {"id": 2, "time": "2013-10-14", "score": 2, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-14", "score": 7, "userName": "Bob"},
    {"id": 4, "time": "2013-10-14", "score": 9, "userName": "Roger"},
    {"id": 5, "time": "2013-10-14", "score": 9, "userName": "Simon"},
    {"id": 6, "time": "2013-10-14", "score": 6, "userName": "Dan"},
    {"id": 7, "time": "2013-10-14", "score": 8, "userName": "Jim"},
    {"id": 8, "time": "2013-10-14", "score": 4, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-14", "score": 6, "userName": "Brian"},
    {"id": 10, "time": "2013-10-14", "score": 8, "userName": "Hank"},
    {"id": 1, "time": "2013-10-15", "score": 5, "userName": "Alice"},
    {"id": 2, "time": "2013-10-15", "score": 3, "userName": "Clyde"},
    {"id": 3, "time": "2013-10-15", "score": 8, "userName": "Bob"},
    {"id": 4, "time": "2013-10-15", "score": 7, "userName": "Roger"},
    {"id": 5, "time": "2013-10-15", "score": 5, "userName": "Simon"},
    {"id": 6, "time": "2013-10-15", "score": 7, "userName": "Dan"},
    {"id": 7, "time": "2013-10-15", "score": 9, "userName": "Jim"},
    {"id": 8, "time": "2013-10-15", "score": 5, "userName": "Stephanie"},
    {"id": 9, "time": "2013-10-15", "score": 6, "userName": "Brian"},
    {"id": 10, "time": "2013-10-15", "score": 6, "userName": "Hank"}
];

$(document).ready(function () {

    $("#user-home-page").empty();
    draw_group_graph("user-home-page", user_dataset);

    $(function() {
        $( "#datepicker" ).datepicker();
    });

    $(".send-msg-to-group").click( function() {
        $("#lC").addClass('active');
        $("#lA").removeClass('active');
        $("#home").removeClass('active');
        $("#msg-tab").addClass('active');
        return false;
    });

    $('#lB').empty();
    $('#lB').append("<h3>Average Mood of Each Group</h3><p></p>");
    draw_group_graph("lB", admin_group_dataset);

    $('.group-mood').click( function () {
            var name = $(this).data("name").split(" ")[0];
            var num_active_members = $(this).data("activemembers");
            var num_inactive_members = $(this).data("inactive");
            $('#B').show();
            $('#B').empty();
            $('#A').hide();

            var specific_dataset = [];
            if (name === "Blue") {
                specific_dataset = blue_group_dataset;
            } else if (name === "Green") {
                specific_dataset = green_group_dataset;
            } else if (name === "Red") {
                specific_dataset = red_group_dataset;
            } else if (name === "Purple") {
                specific_dataset = purple_group_dataset;
            }

            var member_list = "";

            //4 is the number of days - so that there are no multiple names
            for (var i = 0; i < specific_dataset.length/4; i++) {
                member_list += "<div class='row-fluid'>" +
                    "<div class='span3'>" +
                    "<img class='centered' src='/assets/fake_user_small.png'>" +
                    "</div> " +
                    "<div class='span9'>" +
                    "<h5>" +
                    specific_dataset[i].userName +
                    "</h5>" +
                    "</div> " +
                    "</div> ";
            }

            $('#B').append(
                "<h3>" + name + " Group</h3>" +
                    "<div class='row-fluid'>" +
                    "<div class='span9'>" +
                    "<div id='" + name + "'></div>" +
                    "<button class='btn send-msg-to-this-group'>New Message</button> " +
                    "<div><h4>Scheduled Messages</h4>" +
                    "<ul><li>Friday 10am : How are you?</li>" +
                    "<li>Friday 4pm : Are you looking forward to the weekend?</li>" +
                    "<li>Saturday 10am : How was your week?</li></ul>" +
                    "</div>" +
                    "</div> " +
                    "<div id='member-names' class='span2'>" +
                    "<div class='lead'>Members (" + num_active_members + ")</div>" +
                    "<ul id='members-list'>" +
                    "<li>" +
                    "<div class='container-fluid'>" +
                     member_list +
                    "</div> " +
                    "</li>" +
                    "</ul>" +
                    "<div class='row-fluid'>" +
                    "<div class='span12'>" +
                    "</div> " +
                    "</div> " +
                    "</div> " +
                    "</div> " +
                    "</div>"
            );

            draw_group_graph(name, specific_dataset);

            $('#home').click(function () {
                $('#B').empty();
                $('#A').show();
            });

            $(".send-msg-to-this-group").click( function() {
                $("#lC").addClass('active');
                $("#lA").removeClass('active');
                $("#home").removeClass('active');
                $("#msg-tab").addClass('active');
                return false;
            });

            return false;
        }
    );
});

