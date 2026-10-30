class ThreatDetectionAgent:
    def __init__(self):
        # In a real scenario, this would load a ML model or connect to an LLM
        self.risk_keywords = ["help", "stop", "save me", "don't touch"]
        self.threshold_movement = 50.0 # Sudden acceleration

    def evaluate_risk(self, sensor_data):
        risk_score = 0
        
        # 1. Keyword detection
        detected_keywords = [kw for kw in sensor_data.get('audio_keywords', []) if kw.lower() in self.risk_keywords]
        if detected_keywords:
            risk_score += 60
            
        # 2. Sudden movement
        if sensor_data.get('movement_delta', 0) > self.threshold_movement:
            risk_score += 30
            
        # 3. Route deviation (Mock logic)
        # If location is in a known dark zone
        # risk_score += 20
        
        # Decide action based on score
        action = "NONE"
        if risk_score > 80:
            action = "TRIGGER_SOS"
        elif risk_score > 50:
            action = "PROMPT_USER"
            
        return min(risk_score, 100), action
