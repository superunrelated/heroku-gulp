should = require('chai').should()
utils = require('../../src/common/utils')

describe('utils', () ->
	before(() ->
	)

	describe('#createArray', () ->
		it('should create an array', () ->
			arr = utils.createArray(1)
			should.exist(arr)
			arr.should.be.an('array')
		)

		it('should have length 1', () ->
			arr = utils.createArray(1)
			arr.length.should.equal(1)
		)
	)
)