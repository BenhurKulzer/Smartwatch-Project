import Intents

class IntentHandler: INExtension, SendRobotToLocationIntentHandling {
    func handle(intent: SendRobotToLocationIntent, completion: @escaping (SendRobotToLocationIntentResponse) -> Void) {
        let response = SendRobotToLocationIntentResponse.success(message: "Robot will be sent to \(intent.locationName ?? "the specified location")")
        completion(response)
    }
}
