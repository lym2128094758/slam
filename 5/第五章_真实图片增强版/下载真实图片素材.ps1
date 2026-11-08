$ErrorActionPreference = "Continue"
$base = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = Join-Path $base "assets\真实网络素材"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$items = @(
    @{ Name = "10_Dematic_真实仓储AMR.jpg"; Url = "https://www.dematic.com/content/dam/dematic/images/insights/story/AMR_1600x900.jpg" },
    @{ Name = "11_KatoenNatie_真实AMR车队.jpg"; Url = "https://www.katoennatie.com/app/uploads/sites/8/2024/03/TD1_9097_2500_0_150_RGB-2048x1366.jpg" },
    @{ Name = "12_ROS2_Nav2_Gazebo_RViz仿真截图.png"; Url = "https://miro.medium.com/v2/resize%3Afit%3A1400/1%2AC5Jeti69LgJEGDAigYqJzA.png" },
    @{ Name = "13_SLAMToolbox_RViz建图截图.png"; Url = "https://miro.medium.com/1%2Ah56UTaWvhD_l5BFu_3KleQ.png" },
    @{ Name = "14_RTABMap_三维点云截图.png"; Url = "https://www.yahboom.net/public/upload/upload-html/1699598469/image-20230621163801080.png" },
    @{ Name = "15_视觉语言导航真实研究图.png"; Url = "https://haraduka.github.io/omnidirectional-vlm/assets/img/concept.png" },
    @{ Name = "16_VLMaps真实导航研究图.png"; Url = "https://vlmaps.github.io/static/images/cover_lady.png" },
    @{ Name = "17_数字孪生实体机器人对照图.jpg"; Url = "https://media.springernature.com/lw1200/springer-static/image/art%3A10.1007%2Fs44430-025-00010-4/MediaObjects/44430_2025_10_Fig2_HTML.jpg" },
    @{ Name = "18_SLAMToolbox_CircuitLaunch真实GIF.gif"; Url = "https://raw.githubusercontent.com/SteveMacenski/slam_toolbox/ros2/images/circuit_launch.gif" },
    @{ Name = "19_Nav2_Waypoint导航仿真GIF.gif"; Url = "https://raw.githubusercontent.com/ros-navigation/docs.nav2.org/rolling/docs/tutorials/general_tutorials/navigation2_with_gps/assets/interactive_wpf.gif" },
    @{ Name = "20_SLAMToolbox_多机器人建图GIF.gif"; Url = "https://raw.githubusercontent.com/SteveMacenski/slam_toolbox/ros2/images/decentralized_multirobot/multi-robot_mapping.gif" }
)

$ok = 0
foreach ($item in $items) {
    $out = Join-Path $dest $item.Name
    try {
        Invoke-WebRequest -Uri $item.Url -OutFile $out -Headers @{ "User-Agent" = "Mozilla/5.0" } -TimeoutSec 60
        if ((Get-Item $out).Length -gt 1000) {
            Write-Host "[完成] $($item.Name)"
            $ok++
        } else {
            Write-Host "[文件异常] $($item.Name)"
            Remove-Item $out -Force -ErrorAction SilentlyContinue
        }
    } catch {
        Write-Host "[失败] $($item.Name) -- $($_.Exception.Message)"
    }
}
Write-Host ""
Write-Host "下载完成：$ok / $($items.Count) 个文件"
Write-Host "素材目录：$dest"
Read-Host "按回车退出"
