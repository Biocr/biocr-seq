require "./spec_helper"

describe Biocr::Seq do

  it "count DNA Bases" do
    rna = Biocr::Seq::Sequences.to_rna("GATGGAACTTGACTACGTAAATT")
    rna.should eq("GAUGGAACUUGACUACGUAAAUU")
  end

  it "returns reverse complement of a DNA" do
    complement = Biocr::Seq::Sequences.complement("AAAACCCGGT")
    complement.should eq("ACCGGGTTTT")
  end

  it "calculate the GC Content of Sequence" do
    gc = Biocr::Seq::Sequences.gc_content("CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT")
    gc.should eq(60.919540)
  end

  it "calculate the GC Content of all Sequences in FASTA file" do
    fasta = Biocr::Parser::Fasta.new("#{__DIR__}/seq.fasta")
    gc = Biocr::Seq::Sequences.gc_content(fasta)
    gc.should eq({"Fasta_0808", 60.91954})
  end

  it "Finding a motiff in DNA by a subtring" do
    motiff = Biocr::Seq::Sequences.motiff("GATATATGCATATACTT", "ATAT")
    motiff.should eq([2, 4, 10])
  end

  it "Finding a motiff in DNA without a sub" do
    fasta = Biocr::Parser::Fasta.new("#{__DIR__}/motif2.fasta")
    motiff = Biocr::Seq::Sequences.motiff(fasta)
    motiff.should eq("TA")
  end

  it "returns a matrix with profile" do
    profile = Biocr::Seq::Sequences.profile(["ATCCAGCT", "GGGCAACT"])
    profile.should eq({'A' => [1, 0, 0, 0, 2, 1, 0, 0], 'T' => [0, 1, 0, 0, 0, 0, 0, 2], 'C' => [0, 0, 1, 2, 0, 0, 2, 0], 'G' => [1, 1, 1, 0, 0, 1, 0, 0]})
  end

  it "returns a matrix with profile given a Fasta file" do
    fasta = Biocr::Parser::Fasta.new("#{__DIR__}/profile.fasta")
    profile = Biocr::Seq::Sequences.profile(fasta)
    profile.should eq({'A' => [5, 1, 0, 0, 5, 5, 0, 0,], 'T' => [1, 5, 0, 0, 0, 1, 1, 6], 'C' => [0, 0, 1, 4, 2, 0, 6, 1], 'G' => [1, 1, 6, 3, 0, 1, 0, 0]})
  end

  it "returns a consensus provide by a profile" do
    profile = Biocr::Seq::Sequences.profile(["ATCCAGCT", "GGGCAACT", "ATGGATCT", "AAGCAACC", "TTGGAACT", "ATGCCATT", "ATGGCACT"])
    consensus = Biocr::Seq::Sequences.consensus(profile)
    consensus.should eq("ATGCAACT")
  end

end
