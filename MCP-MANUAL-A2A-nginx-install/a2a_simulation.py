# a2a_simulation.py

class Agent:
    def __init__(self, name, tools):
        self.name = name
        self.tools = tools

    def describe_capabilities(self):
        print(f"{self.name} can work with: {', '.join(self.tools)}")

    def collaborate(self, other_agent):
        print(f"{self.name} is collaborating with {other_agent.name}...")
        combined = set(self.tools).union(other_agent.tools)
        print(f"Together, they cover: {', '.join(combined)}")

if __name__ == "__main__":
    devops_agent = Agent("DevOps Agent", ["Docker", "Kubernetes", "CI/CD", "Terraform"])
    monitoring_agent = Agent("Monitoring Agent", ["Datadog", "Prometheus", "Grafana"])
    devops_agent.describe_capabilities()
    monitoring_agent.describe_capabilities()
    devops_agent.collaborate(monitoring_agent)
