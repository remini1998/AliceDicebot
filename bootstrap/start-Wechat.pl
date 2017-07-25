#!/usr/bin/env perl
    use Mojo::Weixin;
    my ($host,$port,$post_api,$poll_api);
    
    $host = "0.0.0.0"; #发送消息接口监听地址，没有特殊需要请不要修改
    $port = 3000;      #发送消息接口监听端口，修改为自己希望监听的端口
    #$post_api = 'http://xxxx';  #接收到的消息上报接口，如果不需要接收消息上报，可以删除或注释此行
    #$poll_api = 'http://xxxx';  #心跳请求地址，默认注释或删掉此行，更多说明参见下文 心跳请求 相关文档
    
    my $client = Mojo::Weixin->new(log_level=>"info",http_debug=>0);
    $client->load("ShowMsg");
    $client->load("Openwx",data=>{
        listen => [{host=>$host,port=>$port}],       #可选，发送消息api监听端口
        post_api=> $post_api,                        #可选，接收消息或事件的上报地址
        post_event => 1,                             #可选，是否上报事件，为了向后兼容性，默认值为0
        post_media_data => 0,                        #可选，是否上报经过base64编码的图片原始数据，默认值为1
        post_event_list => ['login','stop','state_change','input_qrcode'], #可选，上报事件列表，更多说明参考下文 事件上报 相关文档
        poll_api  => $poll_api,                      #可选，心跳请求地址，默认不启用
        poll_interval   => 5,                        #可选，长轮询请求间隔，默认5s
    });
    $client->run();