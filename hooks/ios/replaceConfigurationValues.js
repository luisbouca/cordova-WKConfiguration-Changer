const fs = require('fs');
const path = require('path');

const pluginId = "com-outsystems-changewkconfig";

const ConfigParser = require('cordova-common').ConfigParser;
const config = new ConfigParser("config.xml");
const appName = config.name();

const filePath = path.join("platforms","ios",appName,"Plugins",pluginId,"OSWKWebViewEngine+ConfigurationChanger.m");
const configPath = path.join("package.json"); 

var content = fs.readFileSync(filePath,"utf-8");
const configsString = fs.readFileSync(configPath,"utf-8");

var configs = JSON.parse(configsString);
configs = configs.cordova.plugins[pluginId];

var allowsInlineMediaPlayback = true;
if(configs.hasOwnProperty("allowsInlineMediaPlayback")){
    allowsInlineMediaPlayback = configs.allowsInlineMediaPlayback;
}
var mediaTypesRequiringUserActionForPlayback = false;
if(configs.hasOwnProperty("mediaTypesRequiringUserActionForPlayback")){
    mediaTypesRequiringUserActionForPlayback = configs.mediaTypesRequiringUserActionForPlayback;
}

content = content.replace(/\$allowsInlineMediaPlayback/,allowsInlineMediaPlayback.toString())
content = content.replace(/\$mediaTypesRequiringUserActionForPlayback/,mediaTypesRequiringUserActionForPlayback.toString())

fs.writeFileSync(filePath,content);