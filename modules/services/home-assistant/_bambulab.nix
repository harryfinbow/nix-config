{
  buildHomeAssistantComponent,
  fetchFromGitHub,
  home-assistant,
  ...
}:
buildHomeAssistantComponent rec {
  owner = "greghesp";
  domain = "bambu_lab";
  version = "2.2.22";

  src = fetchFromGitHub {
    inherit owner;
    repo = "ha-bambulab";
    rev = "v${version}";
    hash = "sha256-JRJ+tfllDuMrtz+5VQL2l5nkhJQXRoNvsvFnrReSZHE=";
  };

  dependencies = with home-assistant.python3Packages; [
    beautifulsoup4
    paho-mqtt
  ];
}
