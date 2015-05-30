
var chat = new Chat(app_root+'/chat');
chat.on_get = function(data){
  var m = $('<li>').text(data.name + ' : ' +data.message);
  $('#chat #timeline').prepend(m);
};

var post = function(){
  var name = $('#chat #name').val();
  var message = $('#chat #message').val();
  if(message.length < 1) return;
  chat.post({name: name, message: message});
  $('#chat #message').val('')
};

$(function(){
  chat.start();
  $('#chat #btn_send').click(post);
  $('#chat #message').keydown(function(e){
    if(e.keyCode == 13) post();
  });
});

