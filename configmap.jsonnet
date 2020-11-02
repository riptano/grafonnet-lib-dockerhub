
local configMapName = std.extVar('name') + "-grafana-dashboard";
local dashJson = std.extVar('dashboard');

local dashName = configMapName + "-dashboard.json";

{
    apiVersion: "v1",
    kind: "ConfigMap",
    metadata: {
        name: configMapName,
        labels: {
            grafana_dashboard: "1"
        }
    },
    data: {
        [dashName]: dashJson
    }
}
