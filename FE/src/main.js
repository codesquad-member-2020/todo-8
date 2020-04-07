$( init );

function init() {
  $( ".droppable-area1, .droppable-area2, .droppable-area3" ).sortable({
      connectWith: ".todo-list",
      stack: '.todo-list ul'
    }).disableSelection();
}