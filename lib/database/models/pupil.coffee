{Class, Model} = require '../../database'

module.exports =
  class Pupil extends Model
    @tableName: 'pupils'

    @addFromSims: (record) ->
      pupil = @find('UPN', record.UPN[0])

      klass = Class.find('name', record.RegGroup[0])
      if klass
        klassId = klass.idClass
      else
        Class.insert({name: record.RegGroup[0]})
        klassId = Class.find('name', record.RegGroup[0]).idClass

      if pupil
        @update({
          firstName: @escape(record.ChosenName[0]),
          lastName: @escape(record.Surname[0]),
          UPN: record.UPN[0],
          classId: klassId
        },'idPupils', pupil.idPupils)
      else
        @insert({
          firstName: @escape(record.ChosenName[0]),
          lastName: @escape(record.Surname[0]),
          UPN: record.UPN[0],
          classId: klassId
        })
      return true
