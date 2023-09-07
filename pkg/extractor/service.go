package extractor

var _ Service = &Extractor{}

type Service interface {

}

type Extractor struct {

}

func (e *Extractor) Extract()
}
