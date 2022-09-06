import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.apiKey = this.data.get("apiKey")
    this.sessionId = this.data.get("sessionId")
    this.token = this.data.get("token")
    // start session
    this.initializeSession()
  }
  // disconnect
  disconnect() {
    if(this.session) {
      this.session.disconnect()
    }
  }
  // init session, communicate with OT
  initializeSession() {
    // create OpenTok session
    // suppressing events 
    // this prevents the session object from calling connectionCreated and connectionDestroyed when a client connects 
    // pass a var to the initSession method as an options hash
    var props = { ConnectionEventsSuppressed: true }
    
    this.session = OT.initSession(this.apiKey, this.sessionId, props)
    // connect to a session 

    this.session.connect(this.token, function(error){
      if (error){
        console.log('Error connecting', error.code, error.message)
      } else {
        console.log('Connected to the sessiion')
      }

    });

    // create stream
    // this.session.on('streamCreated', this.streamCreated.bind(this))
    // user joining the room, publisher
    this.publisher = OT.initPublisher(this.element, {
      insertMode: "append",
      width: '50%',
      height: '500px',
      name: this.data.get("name")
    }, this.handleError.bind(this))

  this.session.connect(this.token, this.streamConnected.bind(this))
  }
  // streamCreated
  // streamCreated(event) {
  //   this.session.subscribe(event.stream, this.element, {
  //     insertMode: "append",
  //     width: '100%',
  //     height: '500px',
  //   }, this.handleError.bind(this))
  // }
  // streamConnected
  streamConnected(error) {
    if (error) {
      this.handleError(error)
    }
  }
  // handleError
  handleError(error) {
    if (error) {
      console.error(error.message)
    }
  }
}
