package types

var _ Subscription = &subscription{}

func NewSubscription(payload <-chan Payload, err <-chan error, done <-chan struct{}, quit chan<- struct{}) Subscription {
	return &subscription{
		id:          "", // TODO:
		payloadChan: payload,
		errChan:     err,
		doneChan:    done,
		quitChan:    quit,
	}
}

type subscription struct {
	id          string
	payloadChan <-chan Payload
	errChan     <-chan error
	doneChan    <-chan struct{}
	quitChan    chan<- struct{}
}

func (s *subscription) ID() string {
	return s.id
}

func (s *subscription) Error() <-chan error {
	return s.errChan
}

func (s *subscription) Done() <-chan struct{} {
	return s.doneChan
}

func (s *subscription) Close() error {
	close(s.quitChan)
	return nil
}

func (s *subscription) Payload() <-chan Payload {
	return s.payloadChan
}
