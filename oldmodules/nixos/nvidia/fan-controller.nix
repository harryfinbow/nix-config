{
  config,
  ...
}:

{
  systemd = {
    services.nvidia-fan-controller = {
      enable = config.modules.nvidia.enable;
      description = "Controls NVidia GPU fans";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStop = ''
          /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=0 -c 0
        '';
      };
      script = ''
        /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -c 0

        while true; do
          gpuTemperature=$(/run/current-system/sw/bin/nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

          if [ $gpuTemperature -lt 50 ]; then
            fanSpeed=50
          elif [ $gpuTemperature -lt 60 ]; then
            fanSpeed=60
          elif [ $gpuTemperature -lt 70 ]; then
            fanSpeed=70
          elif [ $gpuTemperature -lt 80 ]; then
            fanSpeed=80
          else
            fanSpeed=100
          fi

          echo "Current Temperature: $gpuTemperature | Target Fan Speed: $fanSpeed"
          /run/current-system/sw/bin/nvidia-settings -a GPUTargetFanSpeed="$fanSpeed" -c 0

          sleep 5
        done
      '';
    };
  };
}
